Message-ID: <485795C7.7020107@...260...>
Date: Tue, 17 Jun 2008 12:45:27 +0200
From: Mathieu GIANNECCHINI <mat.giann@...260...>
MIME-Version: 1.0
References: <4856D294.1060704@...334...>
	<41566C7F-E780-4F7C-8E25-9BB5067F0C0B@...277...>
In-Reply-To: <41566C7F-E780-4F7C-8E25-9BB5067F0C0B@...277...>
Subject: Re: [Openvpn-devel] Merge status of OCSP support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: Davy MELINA <davy.melina@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hello Davy,

I've a question about your patch for OCSP support :

OCSP URL is specified with "ocsp-url" option in configuration. It's OK=20
if you have only one CA in your PKI (and so only one OCSP responder) but=20
what happened if you have a real PKI with multiple CA (so potentially=20
more than one OCSP responder) ?

OCSP responder URI should be stored under AIA (Authority Information=20
Access) extension in each X509 certificate.
What about using AIA extension of each certs (and if it doesn't exist=20
why not the "ocsp-url" specified in the configuration) in order to=20
support multiple CA and multiple OCSP responders in a PKI ?


Regards


Davy MELINA a =E9crit :
> Hi,
>
> I don't know why the OCSP support is not included in the main source =20
> of OpenVPN (i need to update the patch for the rc7), but i know =20
> something:
>
> - if your CRL (in flat file) is not up2date your OpenVPN will not crash
> - if you decide to use OCSP server with OpenVPN (and my patch) and if =20
> your OCSP server crash, your OpenVPN  will be block.
>
> For my experience, I build Two OCSPd behind LVS and i bypass this =20
> problem.
>
> What do you think about that ?
>
> Regards,
>
> Davy
>
> Le 16 juin 08 =E0 22:52, Faidon Liambotis a =E9crit :
>
>  =20
>> Hi,
>> In light of the Debian OpenSSL vulnerability, I was looking for a =20
>> way to efficiently check for revoked certificates.
>> Updating CRLs is one way but it's not exactly efficient.
>>
>> I've found that someone has actually implemented OCSP for OpenVPN[1].
>> Is there any specific reason that this hasn't been merged?
>>
>> I saw evidence on the openvpn-devel archives that this was submitted =20
>> almost a year ago but I didn't see any reviews or comments whatsoever.
>>
>> James, perhaps this should be included in -rc9?
>>
>> Regards,
>> Faidon
>>
>> 1: http://www.block64.net/
>>    =20
>
>
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>
>  =20


