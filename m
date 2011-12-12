From: Tiran Kaskas <Tiran.Kaskas@...1530...>
Date: Mon, 12 Dec 2011 09:32:51 +0000
Message-ID: <A273A2F6519C0D42BFF02CA9C6A825112D003F72@...1531...>
References: <A273A2F6519C0D42BFF02CA9C6A825112D003E1E@...1531...>
	<4EE52A57.1040906@...1338...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F02@...1531...>
In-Reply-To: <A273A2F6519C0D42BFF02CA9C6A825112D003F02@...1531...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Fabian Knittel <fabian.knittel@...1338...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Is there a problem connecting a client running 2.1.4 (the one with polarssl=
) to a server running 2.0.9?

How would the flow typically be?
I see client sending P_CONTROL_HARD_RESET_CLIENT_V2, and then immediately s=
tarts the ssl session (which writes the client hello, but fails to read the=
 server hello).
Shouldn't it be that after sending the P_CONTROL_HARD_RESET_CLIENT_V2 the c=
lient will need to wait for P_CONTROL_HARD_RESET_SERVER_V2?
I do see the P_CONTROL_HARD_RESET_SERVER_V2 comes after some time, but ther=
e is always an attempt to start the ssl session from the client side.

Thanks

-----Original Message-----
From: Tiran Kaskas [mailto:Tiran.Kaskas@...1530...]=20
Sent: Monday, December 12, 2011 9:42 AM
To: Fabian Knittel
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function

You are right, I somehow mixed the data ptr with the struct copy by value.
I do have a problem with returning structures with my 16 bit machine, seems=
 some of the data not being copied (probably need to define far segment).

-----Original Message-----
From: Fabian Knittel [mailto:fabian.knittel@...1338...]=20
Sent: Monday, December 12, 2011 12:11 AM
To: Tiran Kaskas
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function

Hi Tiran,

Am 11.12.2011 21:57, schrieb Tiran Kaskas:
> Looking into the function alloc_buf_gc() in file buffer.c, it returns=20
> a struct buffer, which seems to me is allocated on the stack, which is=20
> causing an issue, I believe, since the function calling alloc_buf_gc()=20
> will work on a buffer which becomes garbage.

'alloc_buf_gc()' is returning 'buf' (of type 'struct buffer') by value, not=
 by pointer, so there is no problem here.  If it were returning 'buf'
by pointer your observation would be correct.  (In C++ a typical mistake wo=
uld be to return 'buf' by reference.)

The function calling 'alloc_buf_gc()' will copy the contents of 'buf' to it=
s local instance of 'struct buffer' before continuing.  (An optimised build=
 might even eliminate the copy.)

Are you observing a specific problem with buffers or did you just happen to=
 stumble over this piece of code?

Cheers
Fabian

---------------------------------------------------------------------------=
---
Learn Windows Azure Live!  Tuesday, Dec 13, 2011
Microsoft is holding a special Learn Windows Azure training event for=20
developers. It will provide a great way to learn Windows Azure and what it=
=20
provides. You can attend the event by watching it streamed LIVE online.=20=
=20
Learn more at http://p.sf.net/sfu/ms-windowsazure
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

