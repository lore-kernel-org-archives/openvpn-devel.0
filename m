Message-ID: <49F78D72.3030104@...1114...>
Date: Wed, 29 Apr 2009 01:12:50 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <49F1B322.6030705@...1032...>	<1240630761l.7894l.0l@...1207...>	<49F34D62.4000302@...1114...>	<m3zle2cwmx.fsf@...1176...>	<1240846947l.13043l.1l@...1207...>	<49F6FA03.6070608@...1032...>
	<1240944303l.12737l.0l@...1207...> <49F75BBB.6000601@...1032...>
In-Reply-To: <49F75BBB.6000601@...1032...>
Subject: Re: [Openvpn-devel] linux openvpn development job
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Siim_P=F5der?= <siim@...1032...>
Cc: openvpn-devel@lists.sourceforge.net, Benny Amorsen <benny+usenet@...1175...>


Siim P=F5der wrote:
> Hi
>=20
> Karl O. Pinc wrote:
>> On 04/28/2009 07:43:47 AM, Siim P=F5der wrote:
>>> Karl O. Pinc wrote:
>> I believe you, but you lost me when it comes to the explanation. What
>> do ssh and grep have to do with adding a hardware encryption card?
>> (I think maybe you're thinking I'm still talking about additional
>> boxes. Recap: My point was that hardware encryption seems to involve
>> kernel/userspace transitions too.)
>=20
> Yes, I was still talking about additional boxes. HW encryption (as i see
> it) will not help at all, because by the current design, all packets
> need to come to userland and go back to kernelland. Most likely to talk
> to the HW encryption device, another round-trip to kernel space would be
> needed?

It's very important to separate between HW encryption boxes (so called
HSM's) and HW encryption accelerators.  The HSM variant, which I have the
impression you are talking about does encryption as well, but are also
suitable for more high security encryption key management as well, with
automatic key rotation, key access control, etc, etc.

The HW encryption accelerator is very often a PCI card (might be they
exists in ISA as well).  These cards can basically only do
encryption/decryption and that's it.

An HSM is very often connected to a network, and uses the TCP/IP stack as
the primary interface, thus giving a much more overhead in the packets
being sent to the device.  The advantage of an HSM is that it does safe
and efficient encryption and decryption of bigger payloads.

The HW accelerator will not have that extreme processing power as an HSM,
but as they are working on the same internal bus as the rest of the
hardware and closer to the encryption/decryption needing software, it can
transfer smaller packages much more quickly and process smaller packages
quicker than an HSM.  I believe many of the accelerators also supports
DMA, which practically gives it instant access to the user memory region
where the payload is stored, without giving the CPU too much extra work.

So for the HW accelerator in an OpenVPN setting, it will be kernel/user
copy when a package is received on the input NIC and data is moved to user
memory.  The HW accelerator will process the user memory data and return
it here, without involving the CPU too much.  The CPU will move the
processed data from user memory to the output NIC.

With an HSM, the data will be needed to be copied from input NIC to user
memory, the application will establish a connection to HSM, copy user
memory to kernel space and push the data to the NIC where the HSM is
located.  Further a similar thing happens when the HSM has processed the da=
ta.

So in this regard, I do not see any advantage of having an HSM processing
VPN data, as the overhead will be the biggest disadvantage.  But it will
be suitable on bigger bulk jobs or jobs requiring strict key management.
And for HW accelerator, it will be much more efficient, as it can work
more independently in user memory (outside kernel space) and the driver
will just signal the main process when data is ready.

This is at least how I've understood things works ... I'm not claiming I'm
right.  It might be I've even misunderstood some bigger parts here as well =
:)


kind regards,

David Sommerseth



>> Out of curiosity, did you test the scheduler per the link supplied by
>> James MacLean?=20
>> http://sourceforge.net/mailarchive/forum.php?thread_name=3D492DBF02.1070=
305%40ednet.ns.ca&forum_name=3Dopenvpn-devel
>=20
> We use openvpn in p2p setup so this would not be applicable.
>=20
> Siim
>=20
> -------------------------------------------------------------------------=
-----
> Register Now & Save for Velocity, the Web Performance & Operations=20
> Conference from O'Reilly Media. Velocity features a full day of=20
> expert-led, hands-on workshops and two days of sessions from industry=20
> leaders in dedicated Performance & Operations tracks. Use code vel09scf=20
> and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

