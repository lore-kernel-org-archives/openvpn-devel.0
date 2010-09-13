Message-ID: <4C8DD1AE.8060006@...515...>
Date: Mon, 13 Sep 2010 10:24:30 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1284075134535506500@...1315...>
	<20100912174719.GP10703@...1296...>
In-Reply-To: <20100912174719.GP10703@...1296...>
Subject: Re: [Openvpn-devel] TCP Window Size - Impact on Data Throughput
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> On Thu, Sep 09, 2010 at 06:32:14PM -0500, openvpn@...1315... wrote:
>=20=20=20
>> I can't explain the information below, but hopefully someone a whole=20
>> bunch smarter than me understands it - as it seems to help with=20
>> TCP throughput in OpenVPN (the holy grail??? ... :-)).
>>=20=20=20=20=20
>
> Did you change TCP window size on the client, or on the OpenVPN process?
>
> If changing the TCP window size on the client helps, this is somewhat
> unsurprising - OpenVPN adds delay, and TCP with a too-small window size
> breaks down miserably if the delay goes up.
>
> What's the "default" TCP window size here?
>
> Given that you can even see an effect in the "direct" case, I suspect that
> your machines' TCP window sizes are *way* too small - and this has not mu=
ch
> to do with TCP-over-TCP, but you would see the same effect for UDP-based
> OpenVPN as well.
>
> Simple example, to clarify the effect of round trip time (delay) on
> TCP throughput:
>
> TCP uses a sliding window, that is, the sender can send as many packets
> as the "window size" permits before the sender has to wait for an acknowl=
edge
> from the receiver.  Now, if the link has a noticeable delay AND lots of
> bandwidth, the bandwidth * time product adds up to the minimum window size
> you need to use:
>
>  1000 Mbit/s link
>  1 ms delay (1/1000s)
>
> 1000 Mbit/s * 1ms =3D 1 Mbit =3D 100 Kbyte "in flight" - that is, if the =
sender=20
> keeps sending packets back to back, with no pause in between, it needs to
> send out 100 kbyte before the first ACK packet comes back.
>
> If the sender only sends 10 kbyte because the TCP window size doesn't per=
mit
> sending more, these 10 kbyte are sent in ~ 0.1 ms, and then it has to=20
> wait for 0.9 ms for the ACKs to come in - send again for 0.1 ms, wait 0.9=
 ms
> (roughly).  So it's only using 10% of the available sending capacity, and
> the performance sucks.
>
>
> So, in your examples, my guess is that the TCP window size is "barely lar=
ge
> enough" for the "direct" case (but the link is not fully saturated unless
> you increase the window size) - and since OpenVPN adds some noticeable
> delay, the bandwidth * delay product goes up, and so needs the window size
> to be able to fully saturate the link...
>=20=20=20
I wonder if the iPerf results only apply to iPerf tests... Linux
autotunes TCP parameters, including send and receive windows[1].
However, increasing the maximum TCP buffer / memory size may be useful
sometimes [2]. Also, an application can choose to use a smaller buffer
than the OS default [2]: apparently iPerf does this. Windows also
autotunes it's TCP parameters[3], although manual editing is an option[4].

Russell: perhaps you could try tuning the OS-level TCP buffer size and
then test the results with a few different real-world applications (e.g.
netcat, scp)?

[1] <http://www.psc.edu/networking/projects/tcptune/#Linux>
[2] <http://www.psc.edu/networking/projects/tcptune/#options>
[3] <http://fasterdata.es.net/TCP-tuning/>
[4]
<http://www.psc.edu/networking/projects/tcptune/OStune/winxp/winxp_stepbyst=
ep.html>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


