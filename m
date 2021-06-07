From: Gehrkens.IT GmbH | Heiko Wundram <heiko.wundram@...2614...>
Date: Mon, 7 Jun 2021 09:38:18 +0000
Message-ID: <4252636e172d4c3eb3c9185cd92d1952@...2614...>
Content-Language: de-DE
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Implement Windows CA template match for
 Crypto-API selector
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hey,

> Just for completeness - I assume that this is a v2 of the patch, and "som=
ething
> was changed".  Since we're all very lazy^Wbusy people, it would be good to
> include a list of v2 changes in the commit message, like this:

sorry for that, too; I added the corresponding info to the amended commit w=
hen rebasing it, but it seems that it wasn't sent out by mail.

v2:
 - style changes in accordance with https://community.openvpn.net/openvpn/w=
iki/CodeStyle
 - use local gc_arena in match function which loops over all certificates
 - sanity check the string length of decoded (old) Windows 2K Certificate T=
emplate extension data
 - fix validity check on loop of all templates

Thanks for having a look!

Heiko

