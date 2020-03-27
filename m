Date: Fri, 27 Mar 2020 17:23:18 +0100
From: Michael Kress <lists@...1660...>
Message-ID: <20200327172318.60171966@...1661...>
In-Reply-To: <11b7bb4a-992e-b97e-9d4e-47ff3e9b1c57@...1227...>
References: <20200323171156.295122f1@...1661...>
 <276a2e33-fa92-0b23-1572-27596052ab33@...1227...>
 <20200324143702.21f24651@...1265...>
 <efc9cf7f-7b20-bb92-08a1-8364490c579f@...1227...>
 <20200325193545.59c59983@...1661...>
 <11b7bb4a-992e-b97e-9d4e-47ff3e9b1c57@...1227...>
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am Thu, 26 Mar 2020 09:38:49 +0100
schrieb Arne Schwabe <arne@...1227...>:

> > RPI? You mean Raspberry PI?
> > Maybe on this machine the problem is not a problem. We also use
> > OpenVPN 2.4.7 on a ARMv7, and there is no obvious problem, just on
> > the old ARMv4.
> > 
> > Finding all problematic places in the code will still be difficult.
> 
> I just look at my RPI and it seems that it has the option you
> mentioned set by default:
> 
> cat /proc/cpu/alignment
> User:		0
> System:		0 (  (null))
> Skipped:	0
> Half:		0
> Word:		0
> DWord:		0
> Multi:		0
> User faults:	2 (fixup)

Yes, this seems to be the default setting for all newer ARM machines.
 
> But it seems that the CPU will not trap but instead allows unaligned
> memory access.
> 
> But since your machine requires that and setting it to 3 (warn+fixup)
> actually fixes the problem you should get warning messages in your
> dmesg output about the points in the code that trigger this problem.

Yes, we decided to solve the problem by setting it to 2. I will have
to make a performance test. I expect a lower performance. Additionally
this old machine is already slow as hell. Debugging and fixing all
eventual alignment problems will most probably take to quite time,
which we have no longer for the next release.

> And you could then either lookup with gdb what the IP addresse are
> pointing to in the the code or (probably easier) configure the kernel
> to send a SIGBUS, so you get a core image and can print a backtrace.
> If we know what code path actually trigger the unaligned access we
> can take a look and figure out what is wrong. Gert has done similar
> things with the sparc machines in the past.

Yes again. Finding all occurences will need a few different setups.

By the way: Stupid as I am it didn't occor to me to check the setting
of /proc/cpu/alignment on the ARMv7 machine, where the problems do not
occur. Now I did and surprise, surprise: It's already set to 2
there :-))

-- 
Servus
  Michael

