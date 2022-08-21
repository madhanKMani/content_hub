# 8 Steps to create Play store Release build without Android Studio


- Update App Version name and Version code
- Check and Verify your Package name
- Create keystore.jks file
- Create and fill values in key.properties file 
- Import keystore details in app/build.gradle file
- Update your signingConfigs block in app/build.gradle file
- Update buildTypes block in app/build.gradle file
- Final Step - Execute terminal command

<br>

## 1. Update App Version name and Version code
> you can change you android version code and version name in local.properties file which you can find it here **{{app_dir_path}}/android/local.properties**

<br>

## 2. Check and Verify your Package name
You can find the package name of your android application in this file path
> **{{app_dir_path}}/android/app/build.gradle**

make sure you **package name, version code and version name** was correct in **defaultConfig** block in app/build.gradle file.

```
defaultConfig {
    applicationId "com.example.appname"
    minSdkVersion 21
    targetSdkVersion 33
    versionCode flutterVersionCode.toInteger()
    versionName flutterVersionName
    multiDexEnabled true 
} 
```

## 3. Create keystore.jks file
Use following commands to generate keystore for your android application.


`
keytool -genkey -v -keystore {{dirPath}}/{{keystoreFileName}}.jks -keyalg RSA -keysize 2048 -validity 10000 -alias {{aliasName}}
`

you need to fill some detail to while executing above command.

Keep this keystore file in safe, once you submit your release build to playstore, you can't generate updated build without this keystore.jks file

## 4. Create key.properties file
Create key.properties file in this path: **{{app_dir_path}}/android/key.properties**

Your **key.properties** should have following detail 

```
storePassword={{passsword_of_your_created_during_keystore}}
keyPassword={{passsword_of_your_created_during_keystore}}
keyAlias={{your_wish}}
storeFile={{your_release_keystore_path}}/{{your_keystore_name}}.jks

debugStorePassword=android
debugKeyPassword=android
debugKeyAlias=androiddebugkey
debugStoreFile={{your_debug_keystore_path}}/.android/debug.keystore
```

## 5. Import keystore details 

Now you need to import keystore detail from key.properties in  app/build.gradle file like this.

```
def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if(localPropertiesFile.exists()) {
    localProperties.load(new FileInputStream(localPropertiesFile))
}

def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if(keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

## 6. Update signingConfig block

Now you need to update your signingConfig block in app/build.gradle file.

```
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword]
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']  
    }

    debug {
        keyAlias keystoreProperties['debugKeyAlias']
        keyPassword keystoreProperties['debugKeyPassword]
        storeFile keystoreProperties['debugStoreFile'] ? file(keystoreProperties['debugStoreFile']) : null
        storePassword keystoreProperties['debugStorePassword']
    }
}
```

## 7. Update buildTypes block
Now you need to update yout buildTypes block in app/build.gradle file.

```
buildTypes {
    release {
        signingConfig signingConfigs.release
    }

    debug {
        signingConfig signingConfigs.debug
    }
}
```

## 8. Final Step - Execute terminal command
Now we are in final step, now we can create release apk (or)aab file using below commands.

To generate release apk you can use following command
> `flutter build apk`

To generate release bundle aab, use following command
> `flutter build appbundle`


once above command executes successfully, it will show you the release file path.
