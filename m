Message-ID: <4EE5DAA1.8000103@...1114...>
Date: Mon, 12 Dec 2011 11:42:41 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <A273A2F6519C0D42BFF02CA9C6A825112D003E1E@...1531...>
	<4EE52A57.1040906@...1338...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F02@...1531...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F72@...1531...>
In-Reply-To: <A273A2F6519C0D42BFF02CA9C6A825112D003F72@...1531...>
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Tiran Kaskas <Tiran.Kaskas@...1530...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/12/11 10:32, Tiran Kaskas wrote:
> Is there a problem connecting a client running 2.1.4 (the one with
> polarssl) to a server running 2.0.9?
> 
> How would the flow typically be? I see client sending
> P_CONTROL_HARD_RESET_CLIENT_V2, and then immediately starts the ssl
> session (which writes the client hello, but fails to read the server
> hello). Shouldn't it be that after sending the
> P_CONTROL_HARD_RESET_CLIENT_V2 the client will need to wait for
> P_CONTROL_HARD_RESET_SERVER_V2? I do see the
> P_CONTROL_HARD_RESET_SERVER_V2 comes after some time, but there is
> always an attempt to start the ssl session from the client side.

Please, don't use 2.0.9.  That versions was released in 2006.  We're soon
ending 2011.  During those years, a lot has happened - including bug and
security fixes.  I would even recommend you to move up to the 2.2 releases.

But yes, there are some configurations which are not 2.0/2.1 compatible.
 But we don't pay attention to that any more.  We rather encourage
everyone to move up to the 2.2 release.

<http://openvpn.net/index.php/open-source/downloads.html>


kind regards,

David Sommerseth

(PS! Also, please don't top-post)

> -----Original Message----- From: Tiran Kaskas
> [mailto:Tiran.Kaskas@...1530...] Sent: Monday, December 12, 2011 9:42
> AM To: Fabian Knittel Cc: openvpn-devel@lists.sourceforge.net Subject:
> Re: [Openvpn-devel] Problem with alloc_buf_gc function
> 
> You are right, I somehow mixed the data ptr with the struct copy by
> value. I do have a problem with returning structures with my 16 bit
> machine, seems some of the data not being copied (probably need to
> define far segment).
> 
> -----Original Message----- From: Fabian Knittel
> [mailto:fabian.knittel@...1338...] Sent: Monday, December 12, 2011
> 12:11 AM To: Tiran Kaskas Cc: openvpn-devel@lists.sourceforge.net 
> Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function
> 
> Hi Tiran,
> 
> Am 11.12.2011 21:57, schrieb Tiran Kaskas:
>> Looking into the function alloc_buf_gc() in file buffer.c, it
>> returns a struct buffer, which seems to me is allocated on the
>> stack, which is causing an issue, I believe, since the function
>> calling alloc_buf_gc() will work on a buffer which becomes garbage.
> 
> 'alloc_buf_gc()' is returning 'buf' (of type 'struct buffer') by
> value, not by pointer, so there is no problem here.  If it were
> returning 'buf' by pointer your observation would be correct.  (In C++
> a typical mistake would be to return 'buf' by reference.)
> 
> The function calling 'alloc_buf_gc()' will copy the contents of 'buf'
> to its local instance of 'struct buffer' before continuing.  (An
> optimised build might even eliminate the copy.)
> 
> Are you observing a specific problem with buffers or did you just
> happen to stumble over this piece of code?
> 
> Cheers Fabian
> 
> ------------------------------------------------------------------------------
>
> 
Learn Windows Azure Live!  Tuesday, Dec 13, 2011
> Microsoft is holding a special Learn Windows Azure training event for
>  developers. It will provide a great way to learn Windows Azure and
> what it provides. You can attend the event by watching it streamed
> LIVE online. Learn more at http://p.sf.net/sfu/ms-windowsazure 
> _______________________________________________ Openvpn-devel mailing
> list Openvpn-devel@lists.sourceforge.net 
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 
> ------------------------------------------------------------------------------
>
> 
Learn Windows Azure Live!  Tuesday, Dec 13, 2011
> Microsoft is holding a special Learn Windows Azure training event for
>  developers. It will provide a great way to learn Windows Azure and
> what it provides. You can attend the event by watching it streamed
> LIVE online. Learn more at http://p.sf.net/sfu/ms-windowsazure 
> _______________________________________________ Openvpn-devel mailing
> list Openvpn-devel@lists.sourceforge.net 
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7l2p4ACgkQDC186MBRfrrQIACfTfRrSO/W5z7fa1GqB+iiiefG
kHwAn2fXdh7ltOoC8tLxKp3niQqLFkwv
=6q+g
-----END PGP SIGNATURE-----

