Message-ID: <4AFC4CBD.7030105@...1114...>
Date: Thu, 12 Nov 2009 18:58:21 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20091110161632.GA31301@...1276...>	<4AFA789B.4070607@...1114...>	<20091111102515.GA19782@...1066...>	<4AFAA745.4030806@...1114...>	<20091111125443.GA29471@...1066...>	<4AFAD26C.7010900@...1114...>
	<20091112153734.GA7157@...1066...>
In-Reply-To: <20091112153734.GA7157@...1066...>
Subject: Re: [Openvpn-devel] Script interface to trigger events depending on
 the validity of a certificate
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/11/09 16:37, Victor Wagner wrote:
> On 2009.11.11 at 16:04:12 +0100, David Sommerseth wrote:
>> I completely agree, that under normal circumstances, it should be enough
>> by letting OpenSSL take care of the certificate chain.  But as OpenVPN
>> now do list more certificates already, I was just trying to keep that
>> possibility still open.
>>
>> In the OpenVPN plug-in I've written which does username, password and
>> certificate authentication, I've been playing with an idea of using the
>> certificate chain to apply different "rules" (network, login hours, etc)
>> based on the certificate chain as well.
> 
> I think it is what certificate policies are for (see RFC 5280).
> 
> Unfortinately  policy support is very poorly documented in the OpenSSL
> (although some documentation for certificate chain verification was added 
> in 1.0.0 beta 4 and it is applicable to early versions as well)

I'm not sure we talk about the same thing now.  I am thinking about a
centralised form of setting a policy for a limited range of users
(client certificates).  But these features mentioned in RFC5280 is only
to be used in CA certificates (which is fine enough) and to use this
information in *validation* of the certificates.  It do not go further
than this, as the validation of the contents of these fields needs to be
done by the application (not OpenSSL but OpenVPN, in this context), how
I understand it.

The eurephia plug-in I've been writing will allow you to authenticate
users based on certificate *and* user name.  And depending on the
combination here, the firewall will be applied with a specific rule to
allow a limited access.  With such rules you can limit each certificate
and user name combination down to IP addresses and port numbers which is
available over the VPN connection.

My intention is to extend the current implementation to take into
consideration which certificates is in the certificate chain, which do
not depend on the policy feature RFC5280 mentions, and apply more
general rules for a bigger group of users.  As this will make it a lot
easier for an administrator to administer in bigger environments.
Another thing, you'd normally trust the information you have locally
than the information sent to you from a client.

And in this connection, I'm looking at implementing other restrictions
as well, as when users are allowed to connect and not (login time
restrictions).


kind regards,

David Sommerseth


> So my patch for policy checking allows only to specify
> several policies to accept. It doesn't pass that policy which was found
> in the certificate after all policy mappings found in CA certificates
> were applied to scripts/plugins. 
> 
> There are also attribute certificates which can be used for such
> autorization purposes as well.
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkr8TLoACgkQDC186MBRfrr8zQCghdLz+8VcvTivdhSfopIDmGQl
nPYAnjUA6mWGfxpCSwzFTocykde4Lepo
=u5dv
-----END PGP SIGNATURE-----

