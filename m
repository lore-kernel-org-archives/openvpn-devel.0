MIME-Version: 1.0
From: Anmol Jain <jain.anmol@...277...>
Date: Sat, 18 Jun 2011 20:42:43 +0530
Message-ID: <BANLkTinexSqdH7YgFTJ+3We8OGWOUGtLkA@...278...>
Content-Type: multipart/alternative; boundary=00504501610943587c04a5fdf016
Subject: [Openvpn-devel] How to modify the OpenVPN code and build it using
	msys for Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--00504501610943587c04a5fdf016
Content-Type: text/plain; charset=ISO-8859-1

Hi All

I have very recently started working on OpenVPN. I need to make some changes
to the source code for my requirement. I am working on a windows machine and
have installed mingw and msys. I was able to generate the OpenVPN installer
for windows by modifying the settings.in to include pre-built libraries but
my aim is to make some changes in the code and then install that. When I
made a simple change in a C file misc.c and re-built the installer the
change didn't reflect. When I did gcc misc.c it gave me the error that not
able to find config.h which is included in syshead.h (which is included in
misc.c originally). Basically I do not know how to build this code and use
the binaries generated thereby for creating the installer. Can anyone please
help?

Thanks,
Anmol

--00504501610943587c04a5fdf016
Content-Type: text/html; charset=ISO-8859-1

Hi All<br><div class="gmail_quote"><br>I have very recently started working on OpenVPN. I need to 
make some changes to the source code for my requirement. I am working on
 a windows machine and have installed mingw and msys. I was able to 
generate the OpenVPN installer for windows by modifying the <a href="http://settings.in" target="_blank">settings.in</a> 
to include pre-built libraries but my aim is to make some changes in the
 code and then install that. When I made a simple change in a C file 
misc.c and re-built the installer the change didn&#39;t reflect. When I did 
gcc misc.c it gave me the error that not able to find config.h which is 
included in syshead.h (which is included in misc.c originally). 
Basically I do not know how to build this code and use the binaries generated thereby for creating the installer. Can anyone please help?<br><br>Thanks,<br><font color="#888888">Anmol
</font></div><br>

--00504501610943587c04a5fdf016--

