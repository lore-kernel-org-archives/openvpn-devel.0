References: <1486364115-9801-1-git-send-email-chipitsine@...277...>
	<20170206104444.12662-1-davids@...515...>
	<CAFHpkQHyXnMPLsv9X5eT9VzkYpTVSJdDPcThT3oOjZEWCDPC+A@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3eaab279-7e82-e3b7-7cb8-b662eb50abde@...2080...>
Date: Mon, 6 Feb 2017 17:33:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHyXnMPLsv9X5eT9VzkYpTVSJdDPcThT3oOjZEWCDPC+A@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="F9PkXrfjSsM8Ji6BHSgt1xLqc6dDqI0Lr"
Subject: Re: [Openvpn-devel] [PATCH applied] github: Add PR template with
 contributor related information
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F9PkXrfjSsM8Ji6BHSgt1xLqc6dDqI0Lr
Content-Type: multipart/mixed; boundary="Nar0Ao4Du5aM2qQ6kqs3hhLSM651hxjB5";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <3eaab279-7e82-e3b7-7cb8-b662eb50abde@...2080...>
Subject: Re: [PATCH applied] github: Add PR template with contributor related
	information
References: <1486364115-9801-1-git-send-email-chipitsine@...277...>
	<20170206104444.12662-1-davids@...515...>
	<CAFHpkQHyXnMPLsv9X5eT9VzkYpTVSJdDPcThT3oOjZEWCDPC+A@...278...>
In-Reply-To: <CAFHpkQHyXnMPLsv9X5eT9VzkYpTVSJdDPcThT3oOjZEWCDPC+A@...278...>

--Nar0Ao4Du5aM2qQ6kqs3hhLSM651hxjB5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 06/02/17 12:19, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
>=20
> it is the same as previous version of this patch, which I sent before
> your guidelines, and you did not complain earlier.
> it is not clear, how 167 chars long might be bad or good. for me it is
> just 167 chars.

You do understand and realize you just prove my earlier points and make
them really obvious? ... you seem not to read and learn ... from the
same URL [1] already provided several times now:

    The seven rules of a great Git commit message
    ---------------------------------------------

    1. Separate subject from body with a blank line
    2. Limit the subject line to 50 characters
    3. Capitalize the subject line
    4. Do not end the subject line with a period
    5. Use the imperative mood in the subject line
    6. Wrap the body at 72 characters
    7. Use the body to explain what and why vs. how

[1] <http://chris.beams.io/posts/git-commit/#seven-rules>

As a clever person once said: "I can only provide the information, I
cannot make you understand it".

> it is not trivial to be sure that it will fit your expectation.
> as an example, there are automatic tests. and you are ok with that.

First ... *read* URL[1], *read* the 7 guidelines above.

Code itself can be automated tested.  But the syntax of the code needs
to be correct to be possible to test it.  From my point of view, making
an analogy: You break the syntax.  It doesn't compile.  Which means the
result isn't testable.

> we should not assign machine job to a man, just involve some
> automation which will tell "your commit message is too long" without
> involving your time.

Those seven rules are not that far away from the coding style guidelines
we all are being picked at from time to time (*including* myself).

It is first and foremost the submitters responsibility to ensure that
everything is in order before doing the submission.  And we have both
on-list, off-list and IRC requests from time to time, where people ask
what kind of guidelines we use, where to find them and so on.  This is a
pretty common behaviour by most community contributors, not even
remotely unique to OpenVPN.  What you want is a way to not take proper
ownership of your contribution, moving the responsibility out of your area.

Sorry, this is not going to happen.

And I don't think I will even have much to say for the future in this
regards.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--Nar0Ao4Du5aM2qQ6kqs3hhLSM651hxjB5--

--F9PkXrfjSsM8Ji6BHSgt1xLqc6dDqI0Lr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYmKVvAAoJEIbPlEyWcf3yjIgQAIyVrcmi0zDnNdBxGaoNOWUe
DvOIlRZxBsAq21XIWDz6dQg64opckiYrFonMVJfFHCxS0lKDR4jfdRMdWwO/EbFn
NdHlvN8xEV6Fq2rUIrn9Xw4RwAVpcHKBqaS+L87xYauEcwDqT+NepwdrCveQ8sLh
QjXkIferNKdYBCL1O4IaDoMxlJjrj6JyKv7xf9zQEdm5R4IrLxeNq+S93fEGucu8
yhjY2uTl/Ui2ICZtkkY1yIBpFftiICG/Rfz4NZu1qaKlvSVsRlNGknk724I/NRo+
WeVjqdzEtVoMbn30K21betgpN0GpsVovi9NyU2FwA2tRYC6khaSw30Qa8BBqCx9G
xni88AC4uxFaVtiqVqA/g9nDFub1/FYyO08gPsPWhY6RB9rBfA42Ldh4etiBgs2K
IW3ybi++wcW+kYRva6EIMMLu1j6UxVLZ+ubnznwwCcB9awWJLbDpK+i/RWUIM14n
v5NgLeoADYESWGf5w3QgCcHYazBkos3LmOqDcmFZbjM6fxvrUKTc3FBBKCqqon31
evoBHRT9paXPd7bTpAxk+dJg844pI81YzpbObrvss4Kxa8rT9v/iOkgckUhNZwX8
bWIZz2VfFoIjSWr6/5L35AENDNBYIIpWvKh5GfE2ro/M+qVdUR2yBo3ILER7P4/S
jf2yoqW9C7eE3+6OHrm4
=CPMi
-----END PGP SIGNATURE-----

--F9PkXrfjSsM8Ji6BHSgt1xLqc6dDqI0Lr--

