References: <20100709083102.GZ361@...1296...>
Date: Sat, 10 Jul 2010 03:30:14 +0200
MIME-Version: 1.0
From: "Matthias Andree" <matthias.andree@...68...>
Message-ID: <op.vfls4oxi1e62zd@...33...>
In-Reply-To: <20100709083102.GZ361@...1296...>
Subject: Re: [Openvpn-devel] Patch for compile-time problems on NetBSD and
 OpenBSD (trac #17)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Am 09.07.2010, 10:31 Uhr, schrieb Gert Doering:

> Hi,
>
> the following patch fixes the IFF_MULTICAST compile-time problems on  
> NetBSD,
> and it should also fix them on OpenBSD (trac entry #17).
>
> ** important: after applying the patch to configure.ac, you MUST run
> ** "autoreconf" - otherwise the patch won't do anything

The "MUST" sounds quite strong here.

Usually, and providing the patch utility does not apply an older timestamp  
to configure.ac, automake will generate Makefiles so that they detect that  
configure needs to be refreshed and re-run.  I sometimes see this fail  
with BSD make, or see that it happens at the *end* of a BSD make run  
rather than at the beginning.  I recall there have been relevant fixes; if  
those are insufficient, and you'd been using the latest release version of  
automake, consider reporting he issue upstream.

I have never seen this with GNU make though - providing your automake is  
new enough and you don't add options so that the user must add  
--enable-maintainer-mdoe (I don't see it on the 2.2beta branch in Git  
though).

-- 
Matthias Andree

