MIME-Version: 1.0
Message-ID: <OFCF903E14.15F8CFEB-ON86257793.001F8E85-86257793.001F9E1F@...1397...>
From: Nicholas Lindberg <nlindber@...1397...>
Date: Fri, 3 Sep 2010 00:45:22 -0500
Content-Type: multipart/alternative;
	boundary="=_alternative 001F9E1D86257793_="
Subject: [Openvpn-devel] OpenVPN w/Intel AES-NI Crypto Acceleration-- How to
	Show Performance Boost?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multipart message in MIME format.
--=_alternative 001F9E1D86257793_=
Content-Type: text/plain; charset="US-ASCII"

Hello,

First time posting to this list, so thanks in advance-- you guys make some 
good software!  I also posted this on the forums but figured this might 
get more coverage.

So, I'll jump right into it-- I've got two versions of OpenSSL 0.9.8* 
running on my Intel [Xeon/Westmere] system. One has been patched to 
leverage the new Intel AES-NI instructions, while the other does not. I've 
verified that these two work appropriately.

Running

"openssl speed --engine aesni -evp aes-128-cbc"

on the optimized executable/library shows significant performance boosts 
as compared to running it without specifying --engine aesni.

So, as a study, I want to see how OpenVPN would benefit from the same 
thing. I've got two versions-- one that utilizes the AES-NI version of 
OpenSSL, the other does not. (This is basically the same thing as 
specifying "--engine aesni" on the command line of OpenVPN as opposed to 
specifying no engine.) I have created a OpenVPN server/client connection 
between two computers behind a subnet at a lab here at work, and I've been 
trying to drive traffic using iperf to show a performance increase with 
the AES-NI version-- but I simply cannot see any performance boost 
whatsoever.

I was able to run a simple loopback self-test using the "--test-crypto" 
command line option built in to OpenVPN along with the "time" command on 
Linux. Basically, I measured how quickly the two could generate 100000 
random packets, starting at 1 byte and going all the way up to 100000 
bytes, and loop them back through the encryption and decryption algorithms 
using aes-128-cbc. Granted, the "--test-crypto" command is doing a number 
of things besides running aes-128-cbc [such as generating random numbers 
to fill packets with, etc] but it indicates that we're getting somewhere.

> time openvpn --test-crypto --secret key-regular --verb 0 --tun-mtu 
100000 --cipher aes-128-cbc

real 4m58.195s
user 4m57.363s
sys 0m0.000s

> time openvpn --test-crypto --secret key-aesni --verb 0 --tun-mtu 100000 
--cipher aes-128-cbc --engine aesni

real 4m14.874s
user 4m14.160s
sys 0m0.000s

The optimized AES-NI version finishes about 44 seconds faster than the 
non-optimized version.

Other than that, I have been able to notice no discernible difference 
using aes-128-cbc, aes-192-cbc, or aes-256-cbc when the engine is engaged 
as opposed to not engaged while trying to drive traffic over a network 
between a client and server [both i7 boxes] with iperf. I've even tried 
running iperf with multiple threads (using the -P option) to no avail.

Does anybody know of a way or perhaps have a clever idea for me to stress 
test this system to show how AES NI can really juice the performance? I 
know the RSA key exchange only happens at the beginning, and to my 
understanding [which is far from perfect] everything in between should 
really be contingent on one of two things:

a) network speed/infastructure/latency
b) how quickly the server can encrypt the data to send it across, etc.

From what I can gather, OpenVPN is single threaded, which already sounds 
like a bottleneck in and of itself-- so what about running multiple copies 
of the OpenVPN server and having a client/clients attached to each server, 
all generating iperf traffic at once? I'm just not sure if that would 
help. I'm a little stuck, and before I spend a ton more time trying 
different things, I thought it would be smart to consult the experts.

It would be really great to realize a situation that allows OpenVPN to 
significantly benefit from the builtin AES-NI booster instructions on this 
architecture. However, I'm afraid that the there are other bottlenecks not 
allowing the AES-NI booster instructions to shine, such as kernel-user 
level interactions, network link speed, etc. Thus-- your help is greatly 
appreciated in helping me better understand what might be going on.

I tried muddling with the loopback feature a bit to remove any and all 
network variables, but that didn't get me anywhere. So far the 
"--test-crypto" has been the best indication that OpenVPN can indeed 
benefit from OpenSSL crypto accelerators.

Thank you so much--

Nick Lindberg
IBM Hardware Architecture Performance
414-258-1639

--=_alternative 001F9E1D86257793_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hello,</font>
<br>
<br><font size=2 face="sans-serif">First time posting to this list, so
thanks in advance-- you guys make some good software! &nbsp;I also posted
this on the forums but figured this might get more coverage.</font>
<br>
<br><font size=2 face="sans-serif">So, I'll jump right into it-- I've got
two versions of OpenSSL 0.9.8* running on my Intel [Xeon/Westmere] system.
One has been patched to leverage the new Intel AES-NI instructions, while
the other does not. I've verified that these two work appropriately.</font>
<br>
<br><font size=2 face="sans-serif">Running</font>
<br>
<br><font size=2 face="sans-serif">&quot;openssl speed --engine aesni -evp
aes-128-cbc&quot;</font>
<br>
<br><font size=2 face="sans-serif">on the optimized executable/library
shows significant performance boosts as compared to running it without
specifying --engine aesni.</font>
<br>
<br><font size=2 face="sans-serif">So, as a study, I want to see how OpenVPN
would benefit from the same thing. I've got two versions-- one that utilizes
the AES-NI version of OpenSSL, the other does not. (This is basically the
same thing as specifying &quot;--engine aesni&quot; on the command line
of OpenVPN as opposed to specifying no engine.) I have created a OpenVPN
server/client connection between two computers behind a subnet at a lab
here at work, and I've been trying to drive traffic using iperf to show
a performance increase with the AES-NI version-- but I simply cannot see
any performance boost whatsoever.</font>
<br>
<br><font size=2 face="sans-serif">I was able to run a simple loopback
self-test using the &quot;--test-crypto&quot; command line option built
in to OpenVPN along with the &quot;time&quot; command on Linux. Basically,
I measured how quickly the two could generate 100000 random packets, starting
at 1 byte and going all the way up to 100000 bytes, and loop them back
through the encryption and decryption algorithms using aes-128-cbc. Granted,
the &quot;--test-crypto&quot; command is doing a number of things besides
running aes-128-cbc [such as generating random numbers to fill packets
with, etc] but it indicates that we're getting somewhere.</font>
<br>
<br><font size=2 face="sans-serif">&gt; time openvpn --test-crypto --secret
key-regular --verb 0 --tun-mtu 100000 --cipher aes-128-cbc</font>
<br>
<br><font size=2 face="sans-serif">real 4m58.195s</font>
<br><font size=2 face="sans-serif">user 4m57.363s</font>
<br><font size=2 face="sans-serif">sys 0m0.000s</font>
<br>
<br><font size=2 face="sans-serif">&gt; time openvpn --test-crypto --secret
key-aesni --verb 0 --tun-mtu 100000 --cipher aes-128-cbc --engine aesni</font>
<br>
<br><font size=2 face="sans-serif">real 4m14.874s</font>
<br><font size=2 face="sans-serif">user 4m14.160s</font>
<br><font size=2 face="sans-serif">sys 0m0.000s</font>
<br>
<br><font size=2 face="sans-serif">The optimized AES-NI version finishes
about 44 seconds faster than the non-optimized version.</font>
<br>
<br><font size=2 face="sans-serif">Other than that, I have been able to
notice no discernible difference using aes-128-cbc, aes-192-cbc, or aes-256-cbc
when the engine is engaged as opposed to not engaged while trying to drive
traffic over a network between a client and server [both i7 boxes] with
iperf. I've even tried running iperf with multiple threads (using the -P
option) to no avail.</font>
<br>
<br><font size=2 face="sans-serif">Does anybody know of a way or perhaps
have a clever idea for me to stress test this system to show how AES NI
can really juice the performance? I know the RSA key exchange only happens
at the beginning, and to my understanding [which is far from perfect] everything
in between should really be contingent on one of two things:</font>
<br>
<br><font size=2 face="sans-serif">a) network speed/infastructure/latency</font>
<br><font size=2 face="sans-serif">b) how quickly the server can encrypt
the data to send it across, etc.</font>
<br>
<br><font size=2 face="sans-serif">From what I can gather, OpenVPN is single
threaded, which already sounds like a bottleneck in and of itself-- so
what about running multiple copies of the OpenVPN server and having a client/clients
attached to each server, all generating iperf traffic at once? I'm just
not sure if that would help. I'm a little stuck, and before I spend a ton
more time trying different things, I thought it would be smart to consult
the experts.</font>
<br>
<br><font size=2 face="sans-serif">It would be really great to realize
a situation that allows OpenVPN to significantly benefit from the builtin
AES-NI booster instructions on this architecture. However, I'm afraid that
the there are other bottlenecks not allowing the AES-NI booster instructions
to shine, such as kernel-user level interactions, network link speed, etc.
Thus-- your help is greatly appreciated in helping me better understand
what might be going on.</font>
<br>
<br><font size=2 face="sans-serif">I tried muddling with the loopback feature
a bit to remove any and all network variables, but that didn't get me anywhere.
So far the &quot;--test-crypto&quot; has been the best indication that
OpenVPN can indeed benefit from OpenSSL crypto accelerators.</font>
<br>
<br><font size=2 face="sans-serif">Thank you so much--</font>
<br><font size=2 face="sans-serif"><br>
Nick Lindberg<br>
IBM Hardware Architecture Performance<br>
414-258-1639<br>
</font>
--=_alternative 001F9E1D86257793_=--

