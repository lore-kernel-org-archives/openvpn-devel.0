Message-ID: <44EE4259.40609@...744...>
Date: Thu, 24 Aug 2006 20:20:41 -0400
From: Jason Wittlin-Cohen <jasonwc@...744...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------030200040009090108010005"
Subject: [Openvpn-devel] [Bug Report] build-key-pass does not work in
	Windows version of OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030200040009090108010005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I just installed OpenVPN on a Windows XP SP2 server. I followed the
OpenVPN 2.0 Howto found on www.openvpn.net. The howto states, "If you
would like to password-protect your client keys, substitute the
*build-key-pass* script.". Unfortunately, this did not work. I checked
C:\Program Files\OpenVPN\easy-rsa and found that no build-key-pass.bat
script was present. I was able to create the script myself by
replicating the build-key.bat script and deleting "-nodes", as this
seems to be the only difference between the two scripts. I then created
password-protected keys without issue. Can you please include the
build-key-pass.bat script in the next Windows release to resolve this issue?

BTW, this does not seem to be a problem in Linux. I used OpenVPN 2.0.3
built from source in Debian Sarge and was able to create
password-protected keys without issue. Unless this problem has been
introduced recently, it seems to only affect the Windows release of OpenVPN.

Jason Wittlin-Cohen

--------------030200040009090108010005
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
I just installed OpenVPN on a Windows XP SP2 server. I followed the
OpenVPN 2.0 Howto found on <a class="moz-txt-link-abbreviated" href="http://www.openvpn.net">www.openvpn.net</a>. The howto states, "If you
would like to password-protect your client keys,
substitute the <b>build-key-pass</b> script.". Unfortunately, this did
not work. I checked C:\Program Files\OpenVPN\easy-rsa and found that no
build-key-pass.bat script was present. I was able to create the script
myself by replicating the build-key.bat script and deleting "-nodes",
as this seems to be the only difference between the two scripts. I then
created password-protected keys without issue. Can you please include
the build-key-pass.bat script in the next Windows release to resolve
this issue?<br>
<br>
BTW, this does not seem to be a problem in Linux. I used OpenVPN 2.0.3
built from source in Debian Sarge and was able to create
password-protected keys without issue. Unless this problem has been
introduced recently, it seems to only affect the Windows release of
OpenVPN.<br>
<br>
Jason Wittlin-Cohen<br>
</body>
</html>

--------------030200040009090108010005--

