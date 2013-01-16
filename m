MIME-Version: 1.0
Date: Wed, 16 Jan 2013 20:02:51 +0530
Message-ID: <CADaK0BzLjzS8x82+pqKfNH02Hde9pNVneGY5sv6W8y0qcYMDVw@...278...>
From: Alok Kulkarni <kulsuhas@...277...>
Content-Type: multipart/mixed; boundary=e89a8ff245d9d75e3504d368c00f
Subject: [Openvpn-devel] [PATCH] OpenVpn For Android 4.0: Passing OVPN
 configuration to application through 3rd party app via Intent
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--e89a8ff245d9d75e3504d368c00f
Content-Type: multipart/alternative; boundary=e89a8ff245d9d75e3004d368c00d

--e89a8ff245d9d75e3004d368c00d
Content-Type: text/plain; charset=ISO-8859-1

Hi,I am writing an Android application which needs to Connect to OpenVpn
server using OpnVpn for Android.
I need to pass OVPN configuration to OpenVpn For Android app through my
application.
I can pass the Ovpn file path(Stored on SDcard) to
de.blinkt.openvpn.ConfigConverter.java class through Intent , but i need a
more secure way as i do not want to store the configuration file on SDcard.
I can create the OVPN file through my application and pass it to
ConfigConverter class as a String using Intent

I am inserting the code changes to onStart() method in ConfigConverter.java
class below as well as attaching the entire java file with this mail.

Please let me know the updates.

/**
     * Added code here to import and save vpn configuration file
     * which is passed through intent by external application. This
     * code can be moved to separate class if required. External
     * application will launch an intent for this class and will
     * pass configuration file as a string.
     * The caller application can use following code to pass ovpn
configuration as a String.
     *
     *         Intent i = new Intent();
            i.setData(Uri.parse(ovpnString));
            i.setComponent(new
ComponentName("de.blinkt.openvpn","de.blinkt.openvpn.ConfigConverter"));
            i.putExtra("IS_OVPN_STR_PRESENT", true);
            i.putExtra("PROFILE_NAME", profileName);
            startActivity(i);
     */
    @Override
    protected void onStart() {
        super.onStart();

        mArrayAdapter = new ArrayAdapter<String>(this,
                android.R.layout.simple_list_item_1);
        getListView().setAdapter(mArrayAdapter);
        final android.content.Intent intent = getIntent();

        if (intent != null) {

            final android.net.Uri data = intent.getData();
            if (data != null) {
                // log(R.string.import_experimental);
                log(R.string.importing_config, data.toString());

//Code modification start
                InputStream is = null;
                // check for configuration string parameter ovpnString
                if (intent.getBooleanExtra("IS_OVPN_STR_PRESENT", false)) {
                    is = new
ByteArrayInputStream(data.toString().getBytes());
                    mPossibleName = intent.getStringExtra("PROFILE_NAME");
                    doImport(is);
                } else {
//Code modification end

                    try {
                        if (data.getScheme().equals("file")) {
                            mPossibleName = data.getLastPathSegment();
                            if (mPossibleName != null) {
                                mPossibleName =
mPossibleName.replace(".ovpn","");
                                mPossibleName =
mPossibleName.replace(".conf","");
                            }
                        }
                        is = getContentResolver().openInputStream(data);
                        mPathsegments = data.getPathSegments();

                        doImport(is);
                    } catch (FileNotFoundException e) {
                        log(R.string.import_content_resolve_error);
                    }
                }
            }
        }
        return;
    }

/////////////////////////

Thanks,
Alok

--e89a8ff245d9d75e3004d368c00d
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,I am writing an Android application which needs to Connect to OpenVpn se=
rver using OpnVpn for Android.<br>I need to pass OVPN configuration to Open=
Vpn For Android app through my application.<br>I can pass the Ovpn file pat=
h(Stored on SDcard) to de.blinkt.openvpn.ConfigConverter.java class through=
 Intent , but i need a more secure way as i do not want to store the config=
uration file on SDcard. I can create the OVPN file through my application a=
nd pass it to ConfigConverter class as a String using Intent<br>
<br>I am inserting the code changes to onStart() method in ConfigConverter.=
java class below as well as attaching the entire java file with this mail.<=
br><br>Please let me know the updates.<br><br>/**<br>=A0=A0=A0 =A0* Added c=
ode here to import and save vpn configuration file<br>
=A0=A0=A0 =A0* which is passed through intent by external application. This=
<br>=A0=A0=A0 =A0* code can be moved to separate class if required. Externa=
l<br>=A0=A0=A0 =A0* application will launch an intent for this class and wi=
ll<br>=A0=A0=A0 =A0* pass configuration file as a string.<br>
=A0=A0=A0 =A0* The caller application can use following code to pass ovpn c=
onfiguration as a String.<br>=A0=A0=A0 =A0* <br>=A0=A0=A0 =A0* =A0=A0=A0 =
=A0=A0=A0 Intent i =3D new Intent();<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 i.set=
Data(Uri.parse(ovpnString));<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 i.setComponen=
t(new ComponentName(&quot;de.blinkt.openvpn&quot;,&quot;de.blinkt.openvpn.C=
onfigConverter&quot;));<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 i.putExtra(&quot;IS_OVPN_STR_PRESENT&quot;, t=
rue);<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 i.putExtra(&quot;PROFILE_NAME&quot;,=
 profileName);<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 startActivity(i);<br>=A0=A0=
=A0 =A0*/<br>=A0=A0=A0 @Override<br>=A0=A0=A0 protected void onStart() {<br>
=A0=A0=A0 =A0=A0=A0 super.onStart();<br><br>=A0=A0=A0 =A0=A0=A0 mArrayAdapt=
er =3D new ArrayAdapter&lt;String&gt;(this,<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 android.R.layout.simple_list_item_1);<br>=A0=A0=A0 =A0=A0=A0 =
getListView().setAdapter(mArrayAdapter);<br>=A0=A0=A0 =A0=A0=A0 final andro=
id.content.Intent intent =3D getIntent();<br>
<br>=A0=A0=A0 =A0=A0=A0 if (intent !=3D null) {<br><br>=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 final android.net.Uri data =3D intent.getData();<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 if (data !=3D null) {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 // log(R.string.import_experimental);<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 log(R.string.importing_config, data.toString());<br>
<br>//Code modification start<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 In=
putStream is =3D null;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 // check =
for configuration string parameter ovpnString<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 if (intent.getBooleanExtra(&quot;IS_OVPN_STR_PRESENT&quot;, f=
alse)) {<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 is =3D new ByteArrayInput=
Stream(data.toString().getBytes());<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 mPossibleName =3D intent.getStringExtra(&quot;PROFILE_NAME&qu=
ot;);<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 doImport(is);<br=
>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 } else {<br>
//Code modification end<br><br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 try {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
 if (data.getScheme().equals(&quot;file&quot;)) {<br>=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 mPossibleName =3D data.ge=
tLastPathSegment();<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 if (mPossibleName !=3D null) {<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 mPossibleName =3D mPossibleName.replace(&quot;.ovpn&quot;,&quot;&quo=
t;);<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 mPossibleName =3D mPossibleName.replace(&quot;.conf&quot;,&qu=
ot;&quot;);<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 }<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 }<br>=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 is =3D getContentResolver=
().openInputStream(data);<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 mPathsegments =3D data.getPathSegments();<br>=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 <br>=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 doImport(is);<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 } catch (FileNotFoundExce=
ption e) {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 l=
og(R.string.import_content_resolve_error);<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0 }<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 }<br>=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 }<br>=A0=A0=A0 =A0=A0=A0 }<br>=A0=A0=A0 =A0=A0=
=A0 return;<br>
=A0=A0=A0 }<br><br>/////////////////////////<br><br>Thanks,<br>Alok<br><br>=
<br>

--e89a8ff245d9d75e3004d368c00d--

--e89a8ff245d9d75e3504d368c00f
Content-Type: application/octet-stream; name="ConfigConverter.java"
Content-Disposition: attachment; filename="ConfigConverter.java"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hc0kk49p0

cGFja2FnZSBkZS5ibGlua3Qub3BlbnZwbjsKCmltcG9ydCBqYXZhLmlvLkJ5dGVBcnJheUlucHV0
U3RyZWFtOwppbXBvcnQgamF2YS5pby5GaWxlOwppbXBvcnQgamF2YS5pby5GaWxlSW5wdXRTdHJl
YW07CmltcG9ydCBqYXZhLmlvLkZpbGVOb3RGb3VuZEV4Y2VwdGlvbjsKaW1wb3J0IGphdmEuaW8u
SU9FeGNlcHRpb247CmltcG9ydCBqYXZhLmlvLklucHV0U3RyZWFtOwppbXBvcnQgamF2YS51dGls
Lkxpc3Q7CmltcG9ydCBqYXZhLnV0aWwuVmVjdG9yOwoKaW1wb3J0IGFuZHJvaWQuYXBwLkFjdGl2
aXR5OwppbXBvcnQgYW5kcm9pZC5hcHAuQWxlcnREaWFsb2c7CmltcG9ydCBhbmRyb2lkLmFwcC5B
bGVydERpYWxvZy5CdWlsZGVyOwppbXBvcnQgYW5kcm9pZC5hcHAuTGlzdEFjdGl2aXR5OwppbXBv
cnQgYW5kcm9pZC5jb250ZW50LkFjdGl2aXR5Tm90Rm91bmRFeGNlcHRpb247CmltcG9ydCBhbmRy
b2lkLmNvbnRlbnQuQ29tcG9uZW50TmFtZTsKaW1wb3J0IGFuZHJvaWQuY29udGVudC5JbnRlbnQ7
CmltcG9ydCBhbmRyb2lkLm5ldC5Vcmk7CmltcG9ydCBhbmRyb2lkLm9zLkJ1bmRsZTsKaW1wb3J0
IGFuZHJvaWQub3MuRW52aXJvbm1lbnQ7CmltcG9ydCBhbmRyb2lkLnNlY3VyaXR5LktleUNoYWlu
OwppbXBvcnQgYW5kcm9pZC5zZWN1cml0eS5LZXlDaGFpbkFsaWFzQ2FsbGJhY2s7CmltcG9ydCBh
bmRyb2lkLnV0aWwuQmFzZTY0OwppbXBvcnQgYW5kcm9pZC52aWV3Lk1lbnU7CmltcG9ydCBhbmRy
b2lkLnZpZXcuTWVudUluZmxhdGVyOwppbXBvcnQgYW5kcm9pZC52aWV3Lk1lbnVJdGVtOwppbXBv
cnQgYW5kcm9pZC52aWV3LlZpZXc7CmltcG9ydCBhbmRyb2lkLndpZGdldC5BcnJheUFkYXB0ZXI7
CmltcG9ydCBhbmRyb2lkLndpZGdldC5DaGVja0JveDsKaW1wb3J0IGRlLmJsaW5rdC5vcGVudnBu
LkNvbmZpZ1BhcnNlci5Db25maWdQYXJzZUVycm9yOwoKcHVibGljIGNsYXNzIENvbmZpZ0NvbnZl
cnRlciBleHRlbmRzIExpc3RBY3Rpdml0eSB7CgoJcHVibGljIHN0YXRpYyBmaW5hbCBTdHJpbmcg
SU1QT1JUX1BST0ZJTEUgPSAiZGUuYmxpbmt0Lm9wZW52cG4uSU1QT1JUX1BST0ZJTEUiOwoKCXBy
aXZhdGUgVnBuUHJvZmlsZSBtUmVzdWx0OwoJcHJpdmF0ZSBBcnJheUFkYXB0ZXI8U3RyaW5nPiBt
QXJyYXlBZGFwdGVyOwoKCXByaXZhdGUgTGlzdDxTdHJpbmc+IG1QYXRoc2VnbWVudHM7CgoJcHJp
dmF0ZSBTdHJpbmcgbUFsaWFzTmFtZSA9IG51bGw7CgoJcHJpdmF0ZSBpbnQgUkVTVUxUX0lOU1RB
TExQS0NTMTIgPSA3OwoKCXByaXZhdGUgU3RyaW5nIG1Qb3NzaWJsZU5hbWUgPSBudWxsOwoKCUBP
dmVycmlkZQoJcHJvdGVjdGVkIHZvaWQgb25DcmVhdGUoQnVuZGxlIHNhdmVkSW5zdGFuY2VTdGF0
ZSkgewoJCXN1cGVyLm9uQ3JlYXRlKHNhdmVkSW5zdGFuY2VTdGF0ZSk7CgkJc2V0Q29udGVudFZp
ZXcoUi5sYXlvdXQuY29uZmlnX2NvbnZlcnRlcik7Cgl9CgoJQE92ZXJyaWRlCglwdWJsaWMgYm9v
bGVhbiBvbk9wdGlvbnNJdGVtU2VsZWN0ZWQoTWVudUl0ZW0gaXRlbSkgewoJCWlmIChpdGVtLmdl
dEl0ZW1JZCgpID09IFIuaWQuY2FuY2VsKSB7CgkJCXNldFJlc3VsdChBY3Rpdml0eS5SRVNVTFRf
Q0FOQ0VMRUQpOwoJCQlmaW5pc2goKTsKCQl9IGVsc2UgaWYgKGl0ZW0uZ2V0SXRlbUlkKCkgPT0g
Ui5pZC5vaykgewoJCQlpZiAobVJlc3VsdCA9PSBudWxsKSB7CgkJCQlsb2coIkltcG9ydGluZyB0
aGUgY29uZmlnIGhhZCBlcnJvciwgY2Fubm90IHNhdmUgaXQiKTsKCQkJCXJldHVybiB0cnVlOwoJ
CQl9CgoJCQlJbnRlbnQgaW4gPSBpbnN0YWxsUEtDUzEyKCk7CgoJCQlpZiAoaW4gIT0gbnVsbCkK
CQkJCXN0YXJ0QWN0aXZpdHlGb3JSZXN1bHQoaW4sIFJFU1VMVF9JTlNUQUxMUEtDUzEyKTsKCQkJ
ZWxzZQoJCQkJc2F2ZVByb2ZpbGUoKTsKCgkJCXJldHVybiB0cnVlOwoJCX0KCgkJcmV0dXJuIHN1
cGVyLm9uT3B0aW9uc0l0ZW1TZWxlY3RlZChpdGVtKTsKCgl9CgoJQE92ZXJyaWRlCglwcm90ZWN0
ZWQgdm9pZCBvbkFjdGl2aXR5UmVzdWx0KGludCByZXF1ZXN0Q29kZSwgaW50IHJlc3VsdENvZGUs
IEludGVudCBkYXRhKSB7CgkJaWYgKHJlcXVlc3RDb2RlID09IFJFU1VMVF9JTlNUQUxMUEtDUzEy
KSB7CgkJCWlmIChyZXN1bHRDb2RlID09IEFjdGl2aXR5LlJFU1VMVF9PSykgewoJCQkJc2hvd0Nl
cnREaWFsb2coKTsKCQkJfQoJCX0KCgkJc3VwZXIub25BY3Rpdml0eVJlc3VsdChyZXF1ZXN0Q29k
ZSwgcmVzdWx0Q29kZSwgZGF0YSk7Cgl9CgoJcHJpdmF0ZSB2b2lkIHNhdmVQcm9maWxlKCkgewoJ
CUludGVudCByZXN1bHQgPSBuZXcgSW50ZW50KCk7CgkJUHJvZmlsZU1hbmFnZXIgdnBsID0gUHJv
ZmlsZU1hbmFnZXIuZ2V0SW5zdGFuY2UodGhpcyk7CgoJCWlmICgoKENoZWNrQm94KSBmaW5kVmll
d0J5SWQoUi5pZC5jb3JyZWN0dGxzKSkuaXNDaGVja2VkKCkKCQkJCSYmIGlzT2xkQ05Gb3JtYXQo
KSkgewoJCQljb252ZXJ0VExTUmVtb3RlKCk7CgkJfQoKCQlzZXRVbmlxdWVQcm9maWxlTmFtZSh2
cGwpOwoJCXZwbC5hZGRQcm9maWxlKG1SZXN1bHQpOwoJCXZwbC5zYXZlUHJvZmlsZSh0aGlzLCBt
UmVzdWx0KTsKCQl2cGwuc2F2ZVByb2ZpbGVMaXN0KHRoaXMpOwoJCXJlc3VsdC5wdXRFeHRyYShW
cG5Qcm9maWxlLkVYVFJBX1BST0ZJTEVVVUlELCBtUmVzdWx0LmdldFVVSUQoKQoJCQkJLnRvU3Ry
aW5nKCkpOwoJCXNldFJlc3VsdChBY3Rpdml0eS5SRVNVTFRfT0ssIHJlc3VsdCk7CgkJZmluaXNo
KCk7Cgl9CgoJcHJpdmF0ZSB2b2lkIGNvbnZlcnRUTFNSZW1vdGUoKSB7CgkJaWYgKG1SZXN1bHQu
bVJlbW90ZUNOLnN0YXJ0c1dpdGgoIi8iKSkKCQkJbVJlc3VsdC5tUmVtb3RlQ04gPSBtUmVzdWx0
Lm1SZW1vdGVDTi5zdWJzdHJpbmcoMSk7CgkJbVJlc3VsdC5tUmVtb3RlQ04gPSBtUmVzdWx0Lm1S
ZW1vdGVDTi5yZXBsYWNlKCIvIiwgIiwgIik7Cgl9CgoJcHVibGljIHZvaWQgc2hvd0NlcnREaWFs
b2coKSB7CgkJdHJ5IHsKCQkJS2V5Q2hhaW4uY2hvb3NlUHJpdmF0ZUtleUFsaWFzKHRoaXMsIG5l
dyBLZXlDaGFpbkFsaWFzQ2FsbGJhY2soKSB7CgoJCQkJcHVibGljIHZvaWQgYWxpYXMoU3RyaW5n
IGFsaWFzKSB7CgkJCQkJLy8gQ3JlZGVudGlhbCBhbGlhcyBzZWxlY3RlZC4gUmVtZW1iZXIgdGhl
IGFsaWFzIHNlbGVjdGlvbgoJCQkJCS8vIGZvciBmdXR1cmUgdXNlLgoJCQkJCW1SZXN1bHQubUFs
aWFzID0gYWxpYXM7CgkJCQkJc2F2ZVByb2ZpbGUoKTsKCQkJCX0KCgkJCX0sIG5ldyBTdHJpbmdb
XSB7ICJSU0EiIH0sIC8vIExpc3Qgb2YgYWNjZXB0YWJsZSBrZXkgdHlwZXMuIG51bGwgZm9yCgkJ
CQkJCQkJCQkvLyBhbnkKCQkJCQludWxsLCAvLyBpc3N1ZXIsIG51bGwgZm9yIGFueQoJCQkJCW1S
ZXN1bHQubVNlcnZlck5hbWUsIC8vIGhvc3QgbmFtZSBvZiBzZXJ2ZXIgcmVxdWVzdGluZyB0aGUK
CQkJCQkJCQkJCQkvLyBjZXJ0LCBudWxsIGlmIHVuYXZhaWxhYmxlCgkJCQkJLTEsIC8vIHBvcnQg
b2Ygc2VydmVyIHJlcXVlc3RpbmcgdGhlIGNlcnQsIC0xIGlmIHVuYXZhaWxhYmxlCgkJCQkJbUFs
aWFzTmFtZSk7IC8vIGFsaWFzIHRvIHByZXNlbGVjdCwgbnVsbCBpZiB1bmF2YWlsYWJsZQoJCX0g
Y2F0Y2ggKEFjdGl2aXR5Tm90Rm91bmRFeGNlcHRpb24gYW5mKSB7CgkJCUJ1aWxkZXIgYWIgPSBu
ZXcgQWxlcnREaWFsb2cuQnVpbGRlcih0aGlzKTsKCQkJYWIuc2V0VGl0bGUoUi5zdHJpbmcuYnJv
a2VuX2ltYWdlX2NlcnRfdGl0bGUpOwoJCQlhYi5zZXRNZXNzYWdlKFIuc3RyaW5nLmJyb2tlbl9p
bWFnZV9jZXJ0KTsKCQkJYWIuc2V0UG9zaXRpdmVCdXR0b24oYW5kcm9pZC5SLnN0cmluZy5vaywg
bnVsbCk7CgkJCWFiLnNob3coKTsKCQl9Cgl9CgoJcHJpdmF0ZSBJbnRlbnQgaW5zdGFsbFBLQ1Mx
MigpIHsKCgkJaWYgKCEoKENoZWNrQm94KSBmaW5kVmlld0J5SWQoUi5pZC5pbXBvcnRwa2NzMTIp
KS5pc0NoZWNrZWQoKSkgewoJCQllbWJlZFBLQ1MxMkZpbGUoKTsKCQkJcmV0dXJuIG51bGw7CgkJ
fQoKCQlGaWxlIHBvc3NpYmxlcGtjczEyID0gZmluZEZpbGUobVJlc3VsdC5tUEtDUzEyRmlsZW5h
bWUpOwoJCWlmIChwb3NzaWJsZXBrY3MxMiAhPSBudWxsKSB7CgkJCUludGVudCBpbmtleWludGVu
dCA9IEtleUNoYWluLmNyZWF0ZUluc3RhbGxJbnRlbnQoKTsKCQkJYnl0ZVtdIHBrY3MxMmRhdGE7
CgkJCXRyeSB7CgkJCQlwa2NzMTJkYXRhID0gcmVhZEJ5dGVzRnJvbUZpbGUocG9zc2libGVwa2Nz
MTIpOwoJCQl9IGNhdGNoIChJT0V4Y2VwdGlvbiBlKSB7CgkJCQlyZXR1cm4gbnVsbDsKCQkJfQoK
CQkJaW5rZXlpbnRlbnQucHV0RXh0cmEoS2V5Q2hhaW4uRVhUUkFfUEtDUzEyLCBwa2NzMTJkYXRh
KTsKCgkJCW1BbGlhc05hbWUgPSBwb3NzaWJsZXBrY3MxMi5nZXROYW1lKCkucmVwbGFjZSgiLnAx
MiIsICIiKTsKCQkJaWYgKG1BbGlhc05hbWUuZXF1YWxzKCIiKSkKCQkJCW1BbGlhc05hbWUgPSBu
dWxsOwoKCQkJaWYgKG1BbGlhc05hbWUgIT0gbnVsbCkgewoJCQkJaW5rZXlpbnRlbnQucHV0RXh0
cmEoS2V5Q2hhaW4uRVhUUkFfTkFNRSwgbUFsaWFzTmFtZSk7CgkJCX0KCQkJcmV0dXJuIGlua2V5
aW50ZW50OwoKCQl9CgkJcmV0dXJuIG51bGw7Cgl9CgoJcHJpdmF0ZSB2b2lkIGVtYmVkUEtDUzEy
RmlsZSgpIHsKCQltUmVzdWx0Lm1QS0NTMTJGaWxlbmFtZSA9IGVtYmVkRmlsZShtUmVzdWx0Lm1Q
S0NTMTJGaWxlbmFtZSwgdHJ1ZSk7CgkJaWYgKG1SZXN1bHQubVBLQ1MxMkZpbGVuYW1lLnN0YXJ0
c1dpdGgoVnBuUHJvZmlsZS5JTkxJTkVfVEFHKSkgewoJCQlpZiAobVJlc3VsdC5tQXV0aGVudGlj
YXRpb25UeXBlID09IFZwblByb2ZpbGUuVFlQRV9VU0VSUEFTU19LRVlTVE9SRSkKCQkJCW1SZXN1
bHQubUF1dGhlbnRpY2F0aW9uVHlwZSA9IFZwblByb2ZpbGUuVFlQRV9VU0VSUEFTU19QS0NTMTI7
CgoJCQlpZiAobVJlc3VsdC5tQXV0aGVudGljYXRpb25UeXBlID09IFZwblByb2ZpbGUuVFlQRV9L
RVlTVE9SRSkKCQkJCW1SZXN1bHQubUF1dGhlbnRpY2F0aW9uVHlwZSA9IFZwblByb2ZpbGUuVFlQ
RV9QS0NTMTI7CgoJCX0KCX0KCglwcml2YXRlIHZvaWQgc2V0VW5pcXVlUHJvZmlsZU5hbWUoUHJv
ZmlsZU1hbmFnZXIgdnBsKSB7CgkJaW50IGkgPSAwOwoKCQlTdHJpbmcgbmV3bmFtZSA9IG1Qb3Nz
aWJsZU5hbWU7CgoJCXdoaWxlICh2cGwuZ2V0UHJvZmlsZUJ5TmFtZShuZXduYW1lKSAhPSBudWxs
KSB7CgkJCWkrKzsKCQkJaWYgKGkgPT0gMSkKCQkJCW5ld25hbWUgPSBnZXRTdHJpbmcoUi5zdHJp
bmcuY29udmVydGVkX3Byb2ZpbGUpOwoJCQllbHNlCgkJCQluZXduYW1lID0gZ2V0U3RyaW5nKFIu
c3RyaW5nLmNvbnZlcnRlZF9wcm9maWxlX2ksIGkpOwoJCX0KCgkJbVJlc3VsdC5tTmFtZSA9IG5l
d25hbWU7Cgl9CgoJQE92ZXJyaWRlCglwdWJsaWMgYm9vbGVhbiBvbkNyZWF0ZU9wdGlvbnNNZW51
KE1lbnUgbWVudSkgewoJCU1lbnVJbmZsYXRlciBpbmZsYXRlciA9IGdldE1lbnVJbmZsYXRlcigp
OwoJCWluZmxhdGVyLmluZmxhdGUoUi5tZW51LmltcG9ydF9tZW51LCBtZW51KTsKCQlyZXR1cm4g
dHJ1ZTsKCX0KCglwcml2YXRlIFN0cmluZyBlbWJlZEZpbGUoU3RyaW5nIGZpbGVuYW1lKSB7CgkJ
cmV0dXJuIGVtYmVkRmlsZShmaWxlbmFtZSwgZmFsc2UpOwoJfQoKCXByaXZhdGUgU3RyaW5nIGVt
YmVkRmlsZShTdHJpbmcgZmlsZW5hbWUsIGJvb2xlYW4gYmFzZTY0ZW5jb2RlKSB7CgkJaWYgKGZp
bGVuYW1lID09IG51bGwpCgkJCXJldHVybiBudWxsOwoKCQkvLyBBbHJlYWR5IGVtYmVkZGVkLCBu
b3RoaW5nIHRvIGRvCgkJaWYgKGZpbGVuYW1lLnN0YXJ0c1dpdGgoVnBuUHJvZmlsZS5JTkxJTkVf
VEFHKSkKCQkJcmV0dXJuIGZpbGVuYW1lOwoKCQlGaWxlIHBvc3NpYmxlRmlsZSA9IGZpbmRGaWxl
KGZpbGVuYW1lKTsKCQlpZiAocG9zc2libGVGaWxlID09IG51bGwpCgkJCXJldHVybiBudWxsOwoJ
CWVsc2UKCQkJcmV0dXJuIHJlYWRGaWxlQ29udGVudChwb3NzaWJsZUZpbGUsIGJhc2U2NGVuY29k
ZSk7CgoJfQoKCXByaXZhdGUgRmlsZSBmaW5kRmlsZShTdHJpbmcgZmlsZW5hbWUpIHsKCQlpZiAo
ZmlsZW5hbWUgPT0gbnVsbCB8fCBmaWxlbmFtZS5lcXVhbHMoIiIpKQoJCQlyZXR1cm4gbnVsbDsK
CgkJLy8gVHJ5IGRpZmZlbnQgcGF0aCByZWxhdGl2ZSB0byAvbW50L3NkY2FyZAoJCUZpbGUgc2Rj
YXJkID0gRW52aXJvbm1lbnQuZ2V0RXh0ZXJuYWxTdG9yYWdlRGlyZWN0b3J5KCk7CgkJRmlsZSBy
b290ID0gbmV3IEZpbGUoIi8iKTsKCgkJVmVjdG9yPEZpbGU+IGRpcmxpc3QgPSBuZXcgVmVjdG9y
PEZpbGU+KCk7CgoJCWZvciAoaW50IGkgPSBtUGF0aHNlZ21lbnRzLnNpemUoKSAtIDE7IGkgPj0g
MDsgaS0tKSB7CgkJCVN0cmluZyBwYXRoID0gIiI7CgkJCWZvciAoaW50IGogPSAwOyBqIDw9IGk7
IGorKykgewoJCQkJcGF0aCArPSAiLyIgKyBtUGF0aHNlZ21lbnRzLmdldChqKTsKCQkJfQoJCQlk
aXJsaXN0LmFkZChuZXcgRmlsZShwYXRoKSk7CgkJfQoJCWRpcmxpc3QuYWRkKHNkY2FyZCk7CgkJ
ZGlybGlzdC5hZGQocm9vdCk7CgoJCVN0cmluZ1tdIGZpbGVwYXJ0cyA9IGZpbGVuYW1lLnNwbGl0
KCIvIik7CgkJZm9yIChGaWxlIHJvb3RkaXIgOiBkaXJsaXN0KSB7CgkJCVN0cmluZyBzdWZmaXgg
PSAiIjsKCQkJZm9yIChpbnQgaSA9IGZpbGVwYXJ0cy5sZW5ndGggLSAxOyBpID49IDA7IGktLSkg
ewoJCQkJaWYgKGkgPT0gZmlsZXBhcnRzLmxlbmd0aCAtIDEpCgkJCQkJc3VmZml4ID0gZmlsZXBh
cnRzW2ldOwoJCQkJZWxzZQoJCQkJCXN1ZmZpeCA9IGZpbGVwYXJ0c1tpXSArICIvIiArIHN1ZmZp
eDsKCgkJCQlGaWxlIHBvc3NpYmxlRmlsZSA9IG5ldyBGaWxlKHJvb3RkaXIsIHN1ZmZpeCk7CgkJ
CQlpZiAoIXBvc3NpYmxlRmlsZS5jYW5SZWFkKCkpCgkJCQkJY29udGludWU7CgoJCQkJLy8gcmVh
ZCB0aGUgZmlsZSBpbmxpbmUKCQkJCXJldHVybiBwb3NzaWJsZUZpbGU7CgoJCQl9CgkJfQoJCWxv
ZyhSLnN0cmluZy5pbXBvcnRfY291bGRfbm90X29wZW4sIGZpbGVuYW1lKTsKCQlyZXR1cm4gbnVs
bDsKCX0KCglTdHJpbmcgcmVhZEZpbGVDb250ZW50KEZpbGUgcG9zc2libGVGaWxlLCBib29sZWFu
IGJhc2U2NGVuY29kZSkgewoJCWJ5dGVbXSBmaWxlZGF0YTsKCQl0cnkgewoJCQlmaWxlZGF0YSA9
IHJlYWRCeXRlc0Zyb21GaWxlKHBvc3NpYmxlRmlsZSk7CgkJfSBjYXRjaCAoSU9FeGNlcHRpb24g
ZSkgewoJCQlsb2coZS5nZXRMb2NhbGl6ZWRNZXNzYWdlKCkpOwoJCQlyZXR1cm4gbnVsbDsKCQl9
CgoJCVN0cmluZyBkYXRhOwoJCWlmIChiYXNlNjRlbmNvZGUpIHsKCQkJZGF0YSA9IEJhc2U2NC5l
bmNvZGVUb1N0cmluZyhmaWxlZGF0YSwgQmFzZTY0LkRFRkFVTFQpOwoJCX0gZWxzZSB7CgkJCWRh
dGEgPSBuZXcgU3RyaW5nKGZpbGVkYXRhKTsKCgkJfQoJCXJldHVybiBWcG5Qcm9maWxlLklOTElO
RV9UQUcgKyBkYXRhOwoKCX0KCglwcml2YXRlIGJ5dGVbXSByZWFkQnl0ZXNGcm9tRmlsZShGaWxl
IGZpbGUpIHRocm93cyBJT0V4Y2VwdGlvbiB7CgkJSW5wdXRTdHJlYW0gaW5wdXQgPSBuZXcgRmls
ZUlucHV0U3RyZWFtKGZpbGUpOwoKCQlsb25nIGxlbiA9IGZpbGUubGVuZ3RoKCk7CgoJCS8vIENy
ZWF0ZSB0aGUgYnl0ZSBhcnJheSB0byBob2xkIHRoZSBkYXRhCgkJYnl0ZVtdIGJ5dGVzID0gbmV3
IGJ5dGVbKGludCkgbGVuXTsKCgkJLy8gUmVhZCBpbiB0aGUgYnl0ZXMKCQlpbnQgb2Zmc2V0ID0g
MDsKCQlpbnQgYnl0ZXNSZWFkID0gMDsKCQl3aGlsZSAob2Zmc2V0IDwgYnl0ZXMubGVuZ3RoCgkJ
CQkmJiAoYnl0ZXNSZWFkID0gaW5wdXQKCQkJCQkJLnJlYWQoYnl0ZXMsIG9mZnNldCwgYnl0ZXMu
bGVuZ3RoIC0gb2Zmc2V0KSkgPj0gMCkgewoJCQlvZmZzZXQgKz0gYnl0ZXNSZWFkOwoJCX0KCgkJ
aW5wdXQuY2xvc2UoKTsKCQlyZXR1cm4gYnl0ZXM7Cgl9CgoJdm9pZCBlbWJlZEZpbGVzKCkgewoJ
CS8vIFRoaXMgd2hlcmUgSSB3b3VsZCBsaWtlIHRvIGhhdmUgYSBjKysgc3R5bGUKCQkvLyB2b2lk
IGVtYmVkRmlsZShzdGQ6OnN0cmluZyAmIG9wdGlvbikKCgkJbVJlc3VsdC5tQ2FGaWxlbmFtZSA9
IGVtYmVkRmlsZShtUmVzdWx0Lm1DYUZpbGVuYW1lKTsKCQltUmVzdWx0Lm1DbGllbnRDZXJ0Rmls
ZW5hbWUgPSBlbWJlZEZpbGUobVJlc3VsdC5tQ2xpZW50Q2VydEZpbGVuYW1lKTsKCQltUmVzdWx0
Lm1DbGllbnRLZXlGaWxlbmFtZSA9IGVtYmVkRmlsZShtUmVzdWx0Lm1DbGllbnRLZXlGaWxlbmFt
ZSk7CgkJbVJlc3VsdC5tVExTQXV0aEZpbGVuYW1lID0gZW1iZWRGaWxlKG1SZXN1bHQubVRMU0F1
dGhGaWxlbmFtZSk7CgoJCWlmIChtUmVzdWx0Lm1Vc2VybmFtZSAhPSBudWxsICYmICFtUmVzdWx0
Lm1Vc2VybmFtZS5lcXVhbHMoIiIpKSB7CgkJCVN0cmluZyBkYXRhID0gZW1iZWRGaWxlKG1SZXN1
bHQubVVzZXJuYW1lKTsKCQkJbVJlc3VsdC5tVXNlcm5hbWUgPSBudWxsOwoJCQlpZiAoZGF0YSAh
PSBudWxsKSB7CgkJCQlkYXRhID0gZGF0YS5yZXBsYWNlKFZwblByb2ZpbGUuSU5MSU5FX1RBRywg
IiIpOwoJCQkJU3RyaW5nW10gcGFydHMgPSBkYXRhLnNwbGl0KCJcbiIpOwoJCQkJaWYgKHBhcnRz
Lmxlbmd0aCA+PSAyKSB7CgkJCQkJbVJlc3VsdC5tVXNlcm5hbWUgPSBwYXJ0c1swXTsKCQkJCQlt
UmVzdWx0Lm1QYXNzd29yZCA9IHBhcnRzWzFdOwoJCQkJfQoJCQl9CgkJfQoJfQoKCQoJLyoqCgkg
KiBBZGRlZCBjb2RlIGhlcmUgdG8gaW1wb3J0IGFuZCBzYXZlIHZwbiBjb25maWd1cmF0aW9uIGZp
bGUKCSAqIHdoaWNoIGlzIHBhc3NlZCB0aHJvdWdoIGludGVudCBieSBleHRlcm5hbCBhcHBsaWNh
dGlvbi4gVGhpcwoJICogY29kZSBjYW4gYmUgbW92ZWQgdG8gc2VwYXJhdGUgY2xhc3MgaWYgcmVx
dWlyZWQuIEV4dGVybmFsCgkgKiBhcHBsaWNhdGlvbiB3aWxsIGxhdW5jaCBhbiBpbnRlbnQgZm9y
IHRoaXMgY2xhc3MgYW5kIHdpbGwKCSAqIHBhc3MgY29uZmlndXJhdGlvbiBmaWxlIGFzIGEgc3Ry
aW5nLgoJICogVGhlIGNhbGxlciBhcHBsaWNhdGlvbiBjYW4gdXNlIGZvbGxvd2luZyBjb2RlIHRv
IHBhc3Mgb3ZwbiBjb25maWd1cmF0aW9uIGFzIGEgU3RyaW5nLgoJICogCgkgKiAJCUludGVudCBp
ID0gbmV3IEludGVudCgpOwoJCQlpLnNldERhdGEoVXJpLnBhcnNlKG92cG5TdHJpbmcpKTsKCQkJ
aS5zZXRDb21wb25lbnQobmV3IENvbXBvbmVudE5hbWUoImRlLmJsaW5rdC5vcGVudnBuIiwiZGUu
Ymxpbmt0Lm9wZW52cG4uQ29uZmlnQ29udmVydGVyIikpOwoJCQlpLnB1dEV4dHJhKCJJU19PVlBO
X1NUUl9QUkVTRU5UIiwgdHJ1ZSk7CgkJCWkucHV0RXh0cmEoIlBST0ZJTEVfTkFNRSIsIHByb2Zp
bGVOYW1lKTsKCQkJc3RhcnRBY3Rpdml0eShpKTsKCSAqLwoJQE92ZXJyaWRlCglwcm90ZWN0ZWQg
dm9pZCBvblN0YXJ0KCkgewoJCXN1cGVyLm9uU3RhcnQoKTsKCgkJbUFycmF5QWRhcHRlciA9IG5l
dyBBcnJheUFkYXB0ZXI8U3RyaW5nPih0aGlzLAoJCQkJYW5kcm9pZC5SLmxheW91dC5zaW1wbGVf
bGlzdF9pdGVtXzEpOwoJCWdldExpc3RWaWV3KCkuc2V0QWRhcHRlcihtQXJyYXlBZGFwdGVyKTsK
CQlmaW5hbCBhbmRyb2lkLmNvbnRlbnQuSW50ZW50IGludGVudCA9IGdldEludGVudCgpOwoKCQlp
ZiAoaW50ZW50ICE9IG51bGwpIHsKCgkJCWZpbmFsIGFuZHJvaWQubmV0LlVyaSBkYXRhID0gaW50
ZW50LmdldERhdGEoKTsKCQkJaWYgKGRhdGEgIT0gbnVsbCkgewoJCQkJLy8gbG9nKFIuc3RyaW5n
LmltcG9ydF9leHBlcmltZW50YWwpOwoJCQkJbG9nKFIuc3RyaW5nLmltcG9ydGluZ19jb25maWcs
IGRhdGEudG9TdHJpbmcoKSk7CgkJCQlJbnB1dFN0cmVhbSBpcyA9IG51bGw7CgkJCQkvLyBjaGVj
ayBmb3IgY29uZmlndXJhdGlvbiBzdHJpbmcgcGFyYW1ldGVyIG92cG5TdHJpbmcKCQkJCWlmIChp
bnRlbnQuZ2V0Qm9vbGVhbkV4dHJhKCJJU19PVlBOX1NUUl9QUkVTRU5UIiwgZmFsc2UpKSB7CgkJ
CQkJaXMgPSBuZXcgQnl0ZUFycmF5SW5wdXRTdHJlYW0oZGF0YS50b1N0cmluZygpLmdldEJ5dGVz
KCkpOwoJCQkJCW1Qb3NzaWJsZU5hbWUgPSBpbnRlbnQuZ2V0U3RyaW5nRXh0cmEoIlBST0ZJTEVf
TkFNRSIpOwoJCQkJCWRvSW1wb3J0KGlzKTsKCQkJCX0gZWxzZSB7CgkJCQkJdHJ5IHsKCQkJCQkJ
aWYgKGRhdGEuZ2V0U2NoZW1lKCkuZXF1YWxzKCJmaWxlIikpIHsKCQkJCQkJCW1Qb3NzaWJsZU5h
bWUgPSBkYXRhLmdldExhc3RQYXRoU2VnbWVudCgpOwoJCQkJCQkJaWYgKG1Qb3NzaWJsZU5hbWUg
IT0gbnVsbCkgewoJCQkJCQkJCW1Qb3NzaWJsZU5hbWUgPSBtUG9zc2libGVOYW1lLnJlcGxhY2Uo
Ii5vdnBuIiwiIik7CgkJCQkJCQkJbVBvc3NpYmxlTmFtZSA9IG1Qb3NzaWJsZU5hbWUucmVwbGFj
ZSgiLmNvbmYiLCIiKTsKCQkJCQkJCX0KCQkJCQkJfQoJCQkJCQlpcyA9IGdldENvbnRlbnRSZXNv
bHZlcigpLm9wZW5JbnB1dFN0cmVhbShkYXRhKTsKCQkJCQkJbVBhdGhzZWdtZW50cyA9IGRhdGEu
Z2V0UGF0aFNlZ21lbnRzKCk7CgkJCQkJCQoJCQkJCQlkb0ltcG9ydChpcyk7CgkJCQkJfSBjYXRj
aCAoRmlsZU5vdEZvdW5kRXhjZXB0aW9uIGUpIHsKCQkJCQkJbG9nKFIuc3RyaW5nLmltcG9ydF9j
b250ZW50X3Jlc29sdmVfZXJyb3IpOwoJCQkJCX0KCQkJCX0KCQkJfQoJCX0KCQlyZXR1cm47Cgl9
CgoJcHJpdmF0ZSB2b2lkIGxvZyhTdHJpbmcgbG9nbWVzc2FnZSkgewoJCW1BcnJheUFkYXB0ZXIu
YWRkKGxvZ21lc3NhZ2UpOwoJfQoKCXByaXZhdGUgdm9pZCBkb0ltcG9ydChJbnB1dFN0cmVhbSBp
cykgewoJCUNvbmZpZ1BhcnNlciBjcCA9IG5ldyBDb25maWdQYXJzZXIoKTsKCQl0cnkgewoJCQlj
cC5wYXJzZUNvbmZpZyhpcyk7CgkJCVZwblByb2ZpbGUgdnAgPSBjcC5jb252ZXJ0UHJvZmlsZSgp
OwoJCQltUmVzdWx0ID0gdnA7CgkJCWVtYmVkRmlsZXMoKTsKCQkJZGlzcGxheVdhcm5pbmdzKCk7
CgkJCWxvZyhSLnN0cmluZy5pbXBvcnRfZG9uZSk7CgkJCXJldHVybjsKCgkJfSBjYXRjaCAoSU9F
eGNlcHRpb24gZSkgewoJCQlsb2coUi5zdHJpbmcuZXJyb3JfcmVhZGluZ19jb25maWdfZmlsZSk7
CgkJCWxvZyhlLmdldExvY2FsaXplZE1lc3NhZ2UoKSk7CgkJfSBjYXRjaCAoQ29uZmlnUGFyc2VF
cnJvciBlKSB7CgkJCWxvZyhSLnN0cmluZy5lcnJvcl9yZWFkaW5nX2NvbmZpZ19maWxlKTsKCQkJ
bG9nKGUuZ2V0TG9jYWxpemVkTWVzc2FnZSgpKTsKCQl9CgkJbVJlc3VsdCA9IG51bGw7CgoJfQoK
CXByaXZhdGUgdm9pZCBkaXNwbGF5V2FybmluZ3MoKSB7CgkJaWYgKG1SZXN1bHQubVVzZUN1c3Rv
bUNvbmZpZykgewoJCQlsb2coUi5zdHJpbmcuaW1wb3J0X3dhcm5pbmdfY3VzdG9tX29wdGlvbnMp
OwoJCQlTdHJpbmcgY29wdCA9IG1SZXN1bHQubUN1c3RvbUNvbmZpZ09wdGlvbnM7CgkJCWlmIChj
b3B0LnN0YXJ0c1dpdGgoIiMiKSkgewoJCQkJaW50IHVudGlsID0gY29wdC5pbmRleE9mKCdcbicp
OwoJCQkJY29wdCA9IGNvcHQuc3Vic3RyaW5nKHVudGlsICsgMSk7CgkJCX0KCgkJCWxvZyhjb3B0
KTsKCQl9CgoJCWlmIChtUmVzdWx0Lm1BdXRoZW50aWNhdGlvblR5cGUgPT0gVnBuUHJvZmlsZS5U
WVBFX0tFWVNUT1JFCgkJCQl8fCBtUmVzdWx0Lm1BdXRoZW50aWNhdGlvblR5cGUgPT0gVnBuUHJv
ZmlsZS5UWVBFX1VTRVJQQVNTX0tFWVNUT1JFKSB7CgkJCWZpbmRWaWV3QnlJZChSLmlkLmltcG9y
dHBrY3MxMikuc2V0VmlzaWJpbGl0eShWaWV3LlZJU0lCTEUpOwoJCX0KCgkJaWYgKGlzT2xkQ05G
b3JtYXQoKSkKCQkJZmluZFZpZXdCeUlkKFIuaWQuY29ycmVjdHRscykuc2V0VmlzaWJpbGl0eShW
aWV3LlZJU0lCTEUpOwoJfQoKCXByaXZhdGUgYm9vbGVhbiBpc09sZENORm9ybWF0KCkgewoJCXJl
dHVybiBtUmVzdWx0Lm1DaGVja1JlbW90ZUNOICYmIG1SZXN1bHQubVJlbW90ZUNOLmNvbnRhaW5z
KCIvIikKCQkJCSYmICFtUmVzdWx0Lm1SZW1vdGVDTi5jb250YWlucygiXyIpOwoJfQoKCXByaXZh
dGUgdm9pZCBsb2coaW50IHJlc3NvdXJjZUlkLCBPYmplY3QuLi4gZm9ybWF0QXJncykgewoJCWxv
ZyhnZXRTdHJpbmcocmVzc291cmNlSWQsIGZvcm1hdEFyZ3MpKTsKCX0KfQo=
--e89a8ff245d9d75e3504d368c00f--

