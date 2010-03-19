Message-ID: <4BA39C17.2080401@...1114...>
Date: Fri, 19 Mar 2010 16:45:27 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BA34355.5020300@...515...> <4BA395E5.8010607@...1147...>
In-Reply-To: <4BA395E5.8010607@...1147...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (18th Mar 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 19/03/10 16:19, Jan Just Keijser wrote:
>> Discussed a potential bug where CN gets mixed up with certificate name
>> occasionally after disconnecting. This messes up iptables rulesets and
>> status files:
>>
>> http://article.gmane.org/gmane.network.openvpn.user/29181
>>
>> Agreed that this may indeed be a bug. Decided to do more research:
>>
>> - check what happens if disconnect happens before connection has reached
>>   ACTIVE state
>> - check if this occurs when session is renegotiated (each hour)
>>   
> I tested it but could not reproduce it using openvpn 2.1.1 ; I forgot to 
> mention last night that the user was *also* using a 
> auth-user-pass-verify script . I duplicated his setup but could not 
> reproduce the problem. However, I had already suggested this fix to him:
> 
> diff -Nru multi.c multi.c.patched
> --- multi.c	2009-10-24 21:17:29.000000000 -0200
> +++ multi.c.patched	2010-03-02 14:57:12.000000000 -0300
> @@ -447,6 +447,9 @@
>  multi_client_disconnect_setenv (struct multi_context *m,
>  				struct multi_instance *mi)
>  {
> +  /* setenv incoming cert common name for script */
> +  setenv_str (mi->context.c2.es, "common_name", tls_common_name(mi->context.c2.tls_multi, true));
> +
>    /* setenv client real IP address */
>    setenv_trusted (mi->context.c2.es, get_link_socket_info (&mi->context));
> 
> and he says the problem is now fixed ! Hmmm I never like it when 
> something is fixed when I don't understand *why* it is fixed...

I have not gone into the deepness of this particular issue, but this
patch adds a missing 'common_name' environment variable in the
- --client-disconnect script hook.  The patch looks reasonable, and is
exactly the same code which is found in multi_client_connect_setenv().

It doesn't explain why it only fails 1/5 times.  But I have a vague
feeling this is somehow connected to some stray/wild pointers when
accessing the common_name env. variable.

I've been about to send this patch to the ML, but haven't had too much
time to do that lately - but it's in my patch queue.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkujnBMACgkQDC186MBRfrp/3gCfS5PpygV0FjUx3TQixu0BSo1j
n2kAn2TYNmi79zkq3hKGrTcAQERJLGhT
=727k
-----END PGP SIGNATURE-----

