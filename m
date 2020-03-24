Date: Tue, 24 Mar 2020 18:02:29 +0100
From: Michael Kress <lists@...1660...>
Message-ID: <20200324143702.21f24651@...1265...>
In-Reply-To: <276a2e33-fa92-0b23-1572-27596052ab33@...1227...>
References: <20200323171156.295122f1@...1661...>
 <276a2e33-fa92-0b23-1572-27596052ab33@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Possible memory alignment Problem in 2.4 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am Tue, 24 Mar 2020 11:21:56 +0100
schrieb Arne Schwabe <arne@...1227...>:

> Am 23.03.20 um 17:11 schrieb Michael Kress:
> > Hello list,
> > 
> > There seems to be some kind of alignment problem in OpenVPN 2.4
> > versions on ARMv4 based machines (32 bit), especially when lzo 
> > compression kicks in.
> 
> LZO is known to miscompile with gcc 10 and requires
> -fno-strict-aliasing to compile. and also in my OpenVPN for Android
> app I have to compile lzo with -O1 instead -O2 since it otherwise
> segfaults on armv7a. Android uses LLVM/clang to compile so the broken
> behaviour is present also on other compilers. I never investigated
> which optimisation flag does break in clang/llvm/armv7a.
 
The alignment errors happen in OpenVPN code, not in LZO code. 
We have to use the (ancient) gcc 4.0.0. After upgrading OpenVPN from
2.3 to 2.4 we did not even upgrade LZO from 2.0.6, but linked
statically to the old compiled lib. I doubt that the compiler itself
changes anything here.

> But bottom line is that you probably are running in a similar and I
> would advise to compile lzo with less optimisation.

Thanks for the suggestion! 

Anyways I recompiled LZO without any optimazations and then OpenVPN
2.4.8. Unfortunatelly this changed nothing.

A few questions:
----------------
1) Do you run automated tests of the OpenVPN code on any build server? 

2) If that is the case, is there any test with a version, where 
   -DVERIFY_ALIGNMENT is enabled?

3) If that is also the case, can you see any ERRORS regarding the
   alignment in the logs?

The problem is, that we do not have any power over the clients. It
might well be, that there are even OpenVPN 2.2 clients out there.

-- 
Servus
  Michael

