Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Wed, 24 Sep 2008 13:15:44 -0600
Message-ID: <750B64C66078B34D918257A1AC004DB205441F@...1132...>
From: "Jason R. Coombs" <jaraco@...1130...>
Subject: Re: [Openvpn-devel] [PATCH v4] Use CryptoAPI CA store (was Re:
	[PATCH v3] Use CryptoAPI CA store)
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
To: openvpn-devel@lists.sourceforge.net

I'd really like to see this feature in a future build.

Is there anything more that needs to be done to integrate this into 2.1?
I can help with code cleanup/refactoring.  I don't have a development
environment set up, though, so I'd be working blind.

Cheers,
Jason

On 9/23/07, Faidon Liambotis Wrote:
Alon Bar-Lev wrote:
> On 9/22/07, Faidon Liambotis <paravoid@...1131...> wrote:
>> Alon Bar-Lev wrote:
>>> So you need to use CertVerifyCertificateChainPolicy() with
CERT_CHAIN_POLICY_SSL
>> I'm no Microsoft developer (adn I don't want to be to be honest) but
if
>> I understand it right, it's better to call CertGetCertificateChain()
as
>> I am doing.
>=20
> You need to use both, one for create the chain and the other to verify
> that it meets with system CTL for SSL.
Seems that you are right. Below you will find -v4 of the patch that does
that.

Also, my previous version didn't actually check for revocations,
contrary to what I documented.
I added CERT_CHAIN_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT to the dwFlags of
CertGetCertificateChain.

Let me know what you think.

Thanks,
Faidon


