Message-ID: <5565AD61.2020003@...515...>
Date: Wed, 27 May 2015 14:41:21 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <20150524193011.GK382@...1296...>
In-Reply-To: <20150524193011.GK382@...1296...>
Subject: Re: [Openvpn-devel] rfd: 'serial-tests' automake option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net


> Hi,
>
> somewhere between automake-1.11 and automake-1.14 the default for handling
> "make check" changed from "serial-tests" to "parallel-tests" - which
> sounds harmless, but has the interesting side effect of hiding the output
> of all (potentially parallel-run) test scripts until the summary at the
> end, and even then, only printing the summary, not the detail output.
>
> I can see that this looks much more pretty (and colours, wooh!), but
> for my day-to-day regression testing and for analyzing buildbot failures,
> this just adds extra steps to figure out what it is doing right now, and
> where and why it failed this time - especially in the buildbot case, the
> difference is "the reason is right in the mail" vs "I need to login to
> the buildbot machine, go to the right build directory (of many), and
> grab the log file from there".
>
>
> Fortunately, there is an automake option for this, which I'd propose to
> enable... (well hidden inside "info automake-1.14" -> "Options")

Running the tests in serial and having the failures show up in buildbot=20
emails makes sense to me. Consider this a feature-ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


