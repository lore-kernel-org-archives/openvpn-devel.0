Message-ID: <45E956F7.4030705@...360...>
Date: Sat, 03 Mar 2007 12:07:35 +0100
From: Daniel Zauft <daniel5x0-06@...360...>
MIME-Version: 1.0
Subject: [Openvpn-devel] windows installer version uses easy-rsa 1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

the easy-rsa directory installed by the windows installer comes with the
old easy-rsa 1.0 files. (even current openvpn-2.1_rc2-install.exe)

This bug is not that critical, but it is annoying that easy-rsa still
creates server certificates without extended key usage per default
(openssl.cnf), making the windows user wonder about error messages if
the recommended "remote-cert-tls" option is used. (In this case simply
copying the openssl.cnf from the 2.0 directory did the job, for regular
usage the path to opensc in the newly added pkcs11 section should be
changed).

And if possible please add the following three files to the "Windows"
directory if easy-rsa. They allow to build password protected versions
of the keys (I just copied the files and remove the "-nodes" parameter).
Except of build-key-server-pass.bat i think that they are vital for
security (e.g. the key files are in an unencrypted directory and
physical access is possible).

build-ca-pass.bat

@echo off
cd %HOME%
rem build a request for a cert that will be valid for ten years
openssl req -days 3650 -new -keyout %KEY_DIR%\%1.key -out
%KEY_DIR%\%1.csr -config %KEY_CONFIG%
rem sign the cert request with our ca, creating a cert/key pair
openssl ca -days 3650 -out %KEY_DIR%\%1.crt -in %KEY_DIR%\%1.csr -config
%KEY_CONFIG%
rem delete any .old files created in this process, to avoid future file
creation errors
del /q %KEY_DIR%\*.old

build-key-pass.bat

@echo off
cd %HOME%
rem build a request for a cert that will be valid for ten years
openssl req -days 3650 -new -keyout %KEY_DIR%\%1.key -out
%KEY_DIR%\%1.csr -config %KEY_CONFIG%
rem sign the cert request with our ca, creating a cert/key pair
openssl ca -days 3650 -out %KEY_DIR%\%1.crt -in %KEY_DIR%\%1.csr -config
%KEY_CONFIG%
rem delete any .old files created in this process, to avoid future file
creation errors
del /q %KEY_DIR%\*.old

build-key-server-pass.bat

@echo off
cd %HOME%
rem build a request for a cert that will be valid for ten years
openssl req -days 3650 -new -keyout %KEY_DIR%\%1.key -out
%KEY_DIR%\%1.csr -config %KEY_CONFIG%
rem sign the cert request with our ca, creating a cert/key pair
openssl ca -days 3650 -out %KEY_DIR%\%1.crt -in %KEY_DIR%\%1.csr
-extensions server -config %KEY_CONFIG%
rem delete any .old files created in this process, to avoid future file
creation errors
del /q %KEY_DIR%\*.old




=09
	=09
___________________________________________________________=20
Der fr=FChe Vogel f=E4ngt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail=
: http://mail.yahoo.de


