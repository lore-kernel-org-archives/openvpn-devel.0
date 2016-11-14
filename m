References: <1478870201-17943-1-git-send-email-davids@...515...>
	<20161112150712.GF28918@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <90603a43-24ec-49d0-fb44-b50367a90997@...2080...>
Date: Tue, 15 Nov 2016 00:16:54 +0100
MIME-Version: 1.0
In-Reply-To: <20161112150712.GF28918@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] tun: Fix compiler warnings
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/11/16 16:07, Gert Doering wrote:
> Hi,
> 
> On Fri, Nov 11, 2016 at 02:16:41PM +0100, David Sommerseth wrote:
>> @@ -917,6 +915,12 @@ do_ifconfig (struct tuntap *tt, 
>> management_android_control (management, "IFCONFIG",
>> buf_bptr(&out));
>> 
>> #elif defined(TARGET_SOLARIS) +      const char
>> *ifconfig_ipv6_remote = NULL; + +      if
>> (tt->did_ifconfig_ipv6_setup ) +        { +
>> ifconfig_ipv6_remote = print_in6_addr (tt->remote_ipv6, 0, &gc); 
>> +        }
> 
> NAK :-) - if you clean it up, do it right.  Just stuff this into
> the if clause where it is used, not introducing yet another if(),
> and make the variable local to that block.

Meh, this is just silly.  This was actually fixed in my local git
index, I had just forgotten to do 'git add' to add the last
improvements instead of the hacky "yes, this seems to fix it"-change.

>> @@ -1606,7 +1610,9 @@ open_tun_generic (const char *dev, const
>> char *dev_type, const char *dev_node, tt->actual_name =
>> string_alloc (dynamic_opened ? dynamic_name : dev, NULL); } } 
>> +#endif // !WIN32 && !TARGET_LINUX
> 
> And NAK again - we do not do // comments.

Duh!  I dunno what I was thinking about here ... lunch? dinner?  Not
coding style.


- -- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYKkXmAAoJEIbPlEyWcf3y7yMP/3IB9xJ3XLhfwyKqXKUIikKP
TSjJmZ1vWZVTUKSqmckoBRRdxvwZjuwGM6ortf99HP0KLqmWuuncLYi0irznHJQD
8Ee0ANjjEkWruUNc+oWsO7Gs/phTpQEXwrL3N2uvDS+w8bpFpP/hTkEoTrHo0ck8
OeGdh4y5Ry3rEB10TQxD+PYBTy0W+ewOHxFU1bWdl+8/msFSyOphNYeOmRpKFzEe
xrVNOLyTczwblANgHc4GbDz4PG9xKdZsKdEGQSTEh2xfU1u8HMNwm2qNACBqTZQx
/mr8nmd+6A3Gcyh69sdcqnLoWYaEVk1XNInl/QyxL4VXudEK03X9xKJHuUsaMkgh
4/Qs6tYbBt1I0fLdtALVcrJfEChyforWNz6BbDjlWJtFv054gq/XRK9GmtMKd2Fg
UxOBxksnW9m7R300twnyz29pSOJ0vS+WfL5GahMaTDH9ArfmThnREbAWT68t+geT
gQ1YfJKcK1BmNZSO5jC8jSYx4FQucb3UAds4BH9ip+OUqLD4+YD1JuoHM5oICYW/
wV31+itZ2pejmB/RZxxczHqTeByGYS0vw2N0AeZ5lp704fYUdzlyYFvBlK8gwFDw
+i5JKZnM/yvVAf00GC2nZk7P/7Xhfde5W9IU2Czl3KOlSQQda/bAUvRJZNrZ2+CM
tq4iqOL/5yY1OrUC7gT+
=p479
-----END PGP SIGNATURE-----

