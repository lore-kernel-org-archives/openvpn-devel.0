Message-ID: <4DFEFA5B.1030708@...515...>
Date: Mon, 20 Jun 2011 10:44:27 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <BANLkTinexSqdH7YgFTJ+3We8OGWOUGtLkA@...278...>
In-Reply-To: <BANLkTinexSqdH7YgFTJ+3We8OGWOUGtLkA@...278...>
Content-Type: multipart/alternative;
	boundary="------------000409070700090504000601"
Subject: Re: [Openvpn-devel] How to modify the OpenVPN code and build it
 using msys for Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Anmol Jain <jain.anmol@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000409070700090504000601
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Il 18/06/2011 18:12, Anmol Jain ha scritto:
> Hi All
>
> I have very recently started working on OpenVPN. I need to make some
> changes to the source code for my requirement. I am working on a
> windows machine and have installed mingw and msys. I was able to
> generate the OpenVPN installer for windows by modifying the
> settings.in <http://settings.in> to include pre-built libraries but my
> aim is to make some changes in the code and then install that. When I
> made a simple change in a C file misc.c and re-built the installer the
> change didn't reflect. When I did gcc misc.c it gave me the error that
> not able to find config.h which is included in syshead.h (which is
> included in misc.c originally). Basically I do not know how to build
> this code and use the binaries generated thereby for creating the
> installer. Can anyone please help?
>
> Thanks,
> Anmol
>

Hi Anmol,

There are two ways to build OpenVPN on Windows. The older method is to
use MinGW/Msys. Afaik all you need to know is documented in the
"domake-win" script. The newer method uses Visual Studio 2008+ tools and
is documented here:

<https://community.openvpn.net/openvpn/wiki/BuildingOnWindows>

These two buildsystems are entirely independent: if you're using the
MinGW method you won't need Visual Studio for anything, and vice versa.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------000409070700090504000601
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    Il 18/06/2011 18:12, Anmol Jain ha scritto:
    <blockquote
      cite="mid:BANLkTinexSqdH7YgFTJ+3We8OGWOUGtLkA@...278..."
      type="cite">Hi All<br>
      <div class="gmail_quote"><br>
        I have very recently started working on OpenVPN. I need to make
        some changes to the source code for my requirement. I am working
        on a windows machine and have installed mingw and msys. I was
        able to generate the OpenVPN installer for windows by modifying
        the <a moz-do-not-send="true" href="http://settings.in"
          target="_blank">settings.in</a> to include pre-built libraries
        but my aim is to make some changes in the code and then install
        that. When I made a simple change in a C file misc.c and
        re-built the installer the change didn't reflect. When I did gcc
        misc.c it gave me the error that not able to find config.h which
        is included in syshead.h (which is included in misc.c
        originally). Basically I do not know how to build this code and
        use the binaries generated thereby for creating the installer.
        Can anyone please help?<br>
        <br>
        Thanks,<br>
        <font color="#888888">Anmol
        </font></div>
      <br>
    </blockquote>
    <br>
    Hi Anmol,<br>
    <br>
    There are two ways to build OpenVPN on Windows. The older method is
    to use MinGW/Msys. Afaik all you need to know is documented in the
    "domake-win" script. The newer method uses Visual Studio 2008+ tools
    and is documented here:<br>
    <br>
    <a class="moz-txt-link-rfc2396E" href="https://community.openvpn.net/openvpn/wiki/BuildingOnWindows">&lt;https://community.openvpn.net/openvpn/wiki/BuildingOnWindows&gt;</a><br>
    <br>
    These two buildsystems are entirely independent: if you're using the
    MinGW method you won't need Visual Studio for anything, and vice
    versa.<br>
    <pre class="moz-signature" cols="72">-- 
Samuli Sepp&auml;nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock
</pre>
  </body>
</html>

--------------000409070700090504000601--

