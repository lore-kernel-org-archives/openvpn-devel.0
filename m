From: Chang Im <Chang.IM@...2519...>
Date: Fri, 26 Jul 2019 23:57:47 +0000
Message-ID: <SN6PR10MB30218B0941923CED2B28AA86F0C00@...2520...>
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_SN6PR10MB30218B0941923CED2B28AA86F0C00SN6PR10MB3021namp_"
MIME-Version: 1.0
Subject: [Openvpn-devel] Deferred mode auth_control_file not removed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_000_SN6PR10MB30218B0941923CED2B28AA86F0C00SN6PR10MB3021namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

With openvpn 2.4.5, we are using deferred mode for user verification throug=
h plugin library.  Noticed there are a lot of auth_control_files are left a=
round and wondering if we need to do our own clean up of these files outsid=
e of openvpn.

The scenario involves two factor authentication where end user has to appro=
ve through their smartphone app which may take some time.

The left-over files mostly contains "0" which indicates a failure due to ti=
meout.

If the second factor authentication is done within a minute, then auth_cont=
rol_file is deleted right away if the auth result is failure.  The auth res=
ult is success, then the file is deleted when the connection is closed.

Any suggestion is appreciated.

Thanks.
-chang

--_000_SN6PR10MB30218B0941923CED2B28AA86F0C00SN6PR10MB3021namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
Hi,</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
With openvpn 2.4.5, we are using deferred mode for user verification throug=
h plugin library.&nbsp; Noticed there are a lot of auth_control_files are l=
eft around and wondering if we need to do our own clean up of these files o=
utside of openvpn.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
The scenario involves two factor authentication where end user has to appro=
ve through their smartphone app which may take some time.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
The left-over files mostly contains &quot;0&quot; which indicates a failure=
 due to timeout.&nbsp;</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-s=
erif; font-size: 11pt;"><br>
</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-s=
erif; font-size: 11pt;">If the second factor authentication is done within =
a minute, then auth_control_file is deleted right away if the auth result i=
s failure.&nbsp; The auth result is success,
 then the file is deleted when the connection is closed.</span><br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-s=
erif; font-size: 11pt;"><br>
</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-s=
erif; font-size: 11pt;">Any suggestion is appreciated.</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-s=
erif; font-size: 11pt;"><br>
</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
Thanks.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">-chang</sp=
an><br>
</div>
</body>
</html>

--_000_SN6PR10MB30218B0941923CED2B28AA86F0C00SN6PR10MB3021namp_--

