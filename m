References: <49F1B322.6030705@...1032...> <1240630761l.7894l.0l@...1207...>
	<49F34D62.4000302@...1114...> <m3zle2cwmx.fsf@...1176...>
	<1240846947l.13043l.1l@...1207...> <49F6FA03.6070608@...1032...>
	<1240944303l.12737l.0l@...1207...> <49F75BBB.6000601@...1032...>
	<49F78D72.3030104@...1114...> <49F7F1B0.9080600@...1032...>
From: Benny Amorsen <benny+usenet@...1175...>
Date: Wed, 29 Apr 2009 16:09:31 +0200
In-Reply-To: <49F7F1B0.9080600@...1032...> ("Siim =?utf-8?Q?P=C3=B5de?=
	=?utf-8?Q?r=22's?= message of "Wed\, 29 Apr 2009 09\:20\:32 +0300")
Message-ID: <m3eivb361w.fsf@...1176...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Siim =?utf-8?Q?P=C3=B5der?= <siim@...1032...>
Cc: openvpn-devel@lists.sourceforge.net

Siim P=C3=B5der <siim@...1032...> writes:

> Are you sure crypto accelerators allow DMA from user memory? I don't
> know for sure either, but I would suspect that they would work like any
> other device: copy to kernel, DMA to device, DMA back to kernel, copy to
> user.

Devices don't care if memory belongs to user or kernel. Unless the
kernel restricts the device with an IOMMU; but that is still unusual
when it comes to PC's.


/Benny


