Date: Tue, 28 Apr 2009 15:45:32 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <49F1B322.6030705@...1032...> <1240630761l.7894l.0l@...1207...>
	<49F34D62.4000302@...1114...> <m3zle2cwmx.fsf@...1176...>
	<1240846947l.13043l.1l@...1207...> <49F6FA03.6070608@...1032...>
	<1240944303l.12737l.0l@...1207...> <49F75BBB.6000601@...1032...>
In-Reply-To: <49F75BBB.6000601@...1032...> (from siim@...1032...
	on Tue Apr 28 14:40:43 2009)
Message-Id: <1240951532l.25454l.1l@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] linux openvpn development job
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; DelSp=Yes; Format=Flowed; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: =?iso-8859-1?q?Siim_P=F5der?= <siim@...1032...>
Cc: openvpn-devel@lists.sourceforge.net, Benny Amorsen <benny+usenet@...1175...>


On 04/28/2009 02:40:43 PM, Siim P=F5der wrote:

> Yes, I was still talking about additional boxes. HW encryption (as i
> see
> it) will not help at all, because by the current design, all packets
> need to come to userland and go back to kernelland. Most likely to
> talk
> to the HW encryption device, another round-trip to kernel space would
> be
> needed?

That's what I'm guessing happens in my rudimentary testing.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

