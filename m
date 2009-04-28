Message-ID: <49F75BBB.6000601@...1032...>
Date: Tue, 28 Apr 2009 22:40:43 +0300
From: =?ISO-8859-1?Q?Siim_P=F5der?= <siim@...1032...>
MIME-Version: 1.0
References: <49F1B322.6030705@...1032...>
	<1240630761l.7894l.0l@...1207...>	<49F34D62.4000302@...1114...>
	<m3zle2cwmx.fsf@...1176...>	<1240846947l.13043l.1l@...1207...>
	<49F6FA03.6070608@...1032...> <1240944303l.12737l.0l@...1207...>
In-Reply-To: <1240944303l.12737l.0l@...1207...>
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net, Benny Amorsen <benny+usenet@...1175...>

Hi

Karl O. Pinc wrote:
> On 04/28/2009 07:43:47 AM, Siim P=F5der wrote:
>> Karl O. Pinc wrote:
> I believe you, but you lost me when it comes to the explanation. What
> do ssh and grep have to do with adding a hardware encryption card?
> (I think maybe you're thinking I'm still talking about additional
> boxes. Recap: My point was that hardware encryption seems to involve
> kernel/userspace transitions too.)

Yes, I was still talking about additional boxes. HW encryption (as i see
it) will not help at all, because by the current design, all packets
need to come to userland and go back to kernelland. Most likely to talk
to the HW encryption device, another round-trip to kernel space would be
needed?

> Out of curiosity, did you test the scheduler per the link supplied by
> James MacLean?=20
> http://sourceforge.net/mailarchive/forum.php?thread_name=3D492DBF02.10703=
05%40ednet.ns.ca&forum_name=3Dopenvpn-devel

We use openvpn in p2p setup so this would not be applicable.

Siim

