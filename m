Message-ID: <4FA77AB9.7090001@...1114...>
Date: Mon, 07 May 2012 09:33:13 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz2FzRu8y6FR1xiygh=KCBB=q-N5HrjLLzn5q1_AgL_3ig@...278...>
In-Reply-To: <CAOazyz2FzRu8y6FR1xiygh=KCBB=q-N5HrjLLzn5q1_AgL_3ig@...278...>
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/05/12 18:55, Alon Bar-Lev wrote:
> Hello,
> 
> Now, I also have the courage to ask one more question regarding
> build....
> 
> We currently have: - auth-pam - defer - down-root - examples
> 
> Distribution wise it will be best to allow admin to install plugins
> as own package which requires openvpn, allowing select specific
> plugins, while each has own release cycle and versioning.
> 
> I already made the openvpn-plugin.h available in /usr/include, so 
> there is no real reason to keep the plugins in openvpn tree, as
> they can be complied using their own separate build system.
> 
> for example, if we take RHEL, we can install the following to use
> the auth-pam plugin:
> 
> openvpn openvpn-plugin-auth-pam
> 
> To build plugin we need openvpn-devel.
> 
> What do you say?

I am not quite sure I see the benefit of this.  Just let me first
explain why I find the current splits fine.

- - Splitting out windows build stuff made sense, as openvpn is buildable
  in a autotools capable environment and windows build is really
  something completely different - and this simplifies the OpenVPN code
  base and fixing issues in the build tool chain don't require releasing
  a completely new OpenVPN version.

- - Splitting out Windows TAP driver also made sense, as that's something
  which does not depend on OpenVPN and can be used by other applications
  as well as OpenVPN.  I think of it as a network driver.

- - easy-rsa also made sense, as that's not strictly OpenVPN connected
  and is an alternative to other CA management software.  It only
  provides a module which is needed in OpenVPN if you want PKI/TLS and
  don't have any other CA management system in place already.

The reason I don't see the benefit of splitting out the plug-ins as
much is that they all depend on OpenVPN.  You can not make much use of
these plug-ins without having OpenVPN.  But with Windows TAP driver
and easy-rsa, they can be completely used independently.

Another point is that the plug-ins we have in the source tree, is
officially supported plug-ins.  And especially auth-pam and down-root
are plug-ins which are very useful and we should encourage packagers
to always package those.

Then the example/ and defer/ plug-ins, which are examples.  Maybe it
would rather make sense to merge them somehow?

> BTW: next will be probably to split out the contrib... :)

I would say much of the same logic is valid here as well.  These are
contributed scripts which are useful only when being used in context
with OpenVPN.  And it's not a big maintenance burden having them in
the openvpn tree at all.  And if there are updates here, it's more
natural for me to ship these together with a new OpenVPN version too.

So, I'm in favour of keeping both plug-ins and contrib in the tree as
it is now.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+nerYACgkQDC186MBRfrrMdwCeJ/k8VhlggCQFwKRM0h3r/Z3j
RxUAn1XJ/2HXL7sSy0P1aQI6XegEVlrB
=QrJp
-----END PGP SIGNATURE-----

