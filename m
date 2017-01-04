References: <20161121091013.imxgfilt3byyqu7u@...30...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <6a902934-903d-840e-059d-2da954486645@...1227...>
Date: Wed, 4 Jan 2017 19:21:07 +0100
MIME-Version: 1.0
In-Reply-To: <20161121091013.imxgfilt3byyqu7u@...30...>
Content-Type: multipart/mixed; boundary="------------3154704BAEC9D2E29FA0CB21"
Subject: Re: [Openvpn-devel] Preparing 2.4-beta1 upload to Debian
 (Experimental)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alberto Gonzalez Iniesta <agi@...64...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------3154704BAEC9D2E29FA0CB21
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Am 21.11.16 um 10:10 schrieb Alberto Gonzalez Iniesta:
> Hi,
> 
> I'm preparing an upload to Debian Experimental of 2.4-beta1 in order to
> get the maximum exposition as possible. In the meantime I'd like to know
> your opinion on the following patch that I've been applying to Debian's
> package for some years:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?att=1;bug=367716;filename=openvpn_367716.diff;msg=10
> Fixing this:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=367716
> 
> Thanks,
> 
> Alberto
> 

One thing I noticed. Debian still includes a "route_default_nil.patch".
That patch changes the man page to the command line help which is wrong.

The correct thing is to change the command line (patch attached).

Arne

--------------3154704BAEC9D2E29FA0CB21
Content-Type: text/plain; charset=UTF-8;
	name="0001-Change-command-help-to-match-man-page-and-implementa.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0001-Change-command-help-to-match-man-page-and-implementa.pa";
	filename*1="tch"

=46rom a88d8ba3e81ca34fc2675805a273cd85875c8973 Mon Sep 17 00:00:00 2001
From: Arne Schwabe <arne@...1227...>
Date: Wed, 4 Jan 2017 19:18:46 +0100
Subject: [PATCH] Change command help to match man page and implementation=


---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bfedb6a..80143e6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -198,7 +198,7 @@ static const char usage_message[] =3D
     "                  is established.  Multiple routes can be specified=
=2E\n"
     "                  netmask default: 255.255.255.255\n"
     "                  gateway default: taken from --route-gateway or --=
ifconfig\n"
-    "                  Specify default by leaving blank or setting to \"=
nil\".\n"
+    "                  Specify default by leaving blank or setting to \"=
default\".\n"
     "--route-ipv6 network/bits [gateway] [metric] :\n"
     "                  Add IPv6 route to routing table after connection\=
n"
     "                  is established.  Multiple routes can be specified=
=2E\n"
--=20
2.10.1 (Apple Git-78)


--------------3154704BAEC9D2E29FA0CB21--

