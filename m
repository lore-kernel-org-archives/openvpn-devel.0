Message-ID: <4F4E4A07.10901@...1114...>
Date: Wed, 29 Feb 2012 16:53:43 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...> <4F4D019B.2090704@...1030...>
	<4F4D08EF.6040404@...1114...>
	<4F4E3DD1.3010308@...1030...>
In-Reply-To: <4F4E3DD1.3010308@...1030...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3-alpha1 released
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
To: Mr Dash Four <mr.dash.four@...1030...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 29/02/12 16:01, Mr Dash Four wrote:
> 
>> For the plug-in API ... look at openvpn-plugin.h ... look for 
>> openvpn_plugin_*_v3.  Especially openvpn_plugin_open_v3() and 
>> openvpn_plugin_func_v3().  If fact, most of the openvpn-plugin.h is
>> a pretty comprehensive reference for the plugin API.  For a working 
>> example, look at plugin/examples/log_v3.c.
>> 
>> For the --client-nat ... look at the man new page. 
>> <http://openvpn.net/index.php/manuals/523-openvpn-23.html>
>> 
> Thanks, I'll have a look later on today. Does this differ from the
> "old" plugin mechanism in v2.2?

Yes, it differs quite a bit.  The v3 API is brand new.  It has a very
different argument list than the v1 and v2 API.  However, with the v3 it
is expected that the plug-in API itself (function declarations) will not
change again.  The v3 passes structs with the information, where the v1
and v2 APIs used separate arguments to the plug-in functions.

The advantage here is that the plug-ins don't have to be rebuilt if these
structs are extended in the future.  It's an "unwritten rule" that we
will not reduce or re-order the struct contents, only extend it.  And
there are some version indicators as well, so that if you have a plug-in
depending on a minium struct version; you can check this before
continuing to extract data.  This way, backward compatibility should be
handled pretty nicely.

I would recommend all plug-in writers to mainly focus on the v3 API.  At
some point in the future we might deprecate the old APIs and reduce it to
only one single API.  But anyhow, this won't happen in the near future.

If a plug-in contains both v3, v2 and/or v1 functions, only the newest
version will be used.  So you can write a plug-in which can make
advantage of the new API and features with the latest OpenVPN, while
having a fall-back for older OpenVPN versions.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9OSgQACgkQDC186MBRfro/uwCgmpKDIIfbkoa5wSSp74sWPRBQ
2zEAoJgGvHAwlkN8e7g9Do88FT8zddtD
=SqQN
-----END PGP SIGNATURE-----

