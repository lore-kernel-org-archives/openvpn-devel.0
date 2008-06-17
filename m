Message-Id: <AF9B3AB7-9A8F-4F6E-B886-DE06B8BC4639@...277...>
From: Davy MELINA <davy.melina@...277...>
In-Reply-To: <485795C7.7020107@...260...>
Mime-Version: 1.0 (Apple Message framework v924)
Date: Tue, 17 Jun 2008 13:08:12 +0200
References: <4856D294.1060704@...334...>
	<41566C7F-E780-4F7C-8E25-9BB5067F0C0B@...277...>
	<485795C7.7020107@...260...>
Subject: Re: [Openvpn-devel] Merge status of OCSP support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; delsp=yes; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Mathieu GIANNECCHINI <mat.giann@...260...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Mathieu,

You'r right about my patch, you can use only one OCSP responder and=20=20
it's a great idea to use AIA extension in each X509 certificate.

So, i will find the time to code a new version of my patch or if you=20=20
want to code it with me, i am open :)

Le 17 juin 08 =E0 12:45, Mathieu GIANNECCHINI a =E9crit :

> Hello Davy,
>
> I've a question about your patch for OCSP support :
>
> OCSP URL is specified with "ocsp-url" option in configuration. It's=20=20
> OK if you have only one CA in your PKI (and so only one OCSP=20=20
> responder) but what happened if you have a real PKI with multiple CA=20=20
> (so potentially more than one OCSP responder) ?
>
> OCSP responder URI should be stored under AIA (Authority Information=20=20
> Access) extension in each X509 certificate.
> What about using AIA extension of each certs (and if it doesn't=20=20
> exist why not the "ocsp-url" specified in the configuration) in=20=20
> order to support multiple CA and multiple OCSP responders in a PKI ?
>
>
> Regards
>
>
> Davy MELINA a =E9crit :
>> Hi,
>>
>> I don't know why the OCSP support is not included in the main=20=20
>> source  of OpenVPN (i need to update the patch for the rc7), but i=20=20
>> know  something:
>>
>> - if your CRL (in flat file) is not up2date your OpenVPN will not=20=20
>> crash
>> - if you decide to use OCSP server with OpenVPN (and my patch) and=20=20
>> if  your OCSP server crash, your OpenVPN  will be block.
>>
>> For my experience, I build Two OCSPd behind LVS and i bypass this=20=20=
=20
>> problem.
>>
>> What do you think about that ?
>>
>> Regards,
>>
>> Davy
>>
>> Le 16 juin 08 =E0 22:52, Faidon Liambotis a =E9crit :
>>
>>
>>> Hi,
>>> In light of the Debian OpenSSL vulnerability, I was looking for a=20=20=
=20
>>> way to efficiently check for revoked certificates.
>>> Updating CRLs is one way but it's not exactly efficient.
>>>
>>> I've found that someone has actually implemented OCSP for=20=20
>>> OpenVPN[1].
>>> Is there any specific reason that this hasn't been merged?
>>>
>>> I saw evidence on the openvpn-devel archives that this was=20=20
>>> submitted  almost a year ago but I didn't see any reviews or=20=20
>>> comments whatsoever.
>>>
>>> James, perhaps this should be included in -rc9?
>>>
>>> Regards,
>>> Faidon
>>>
>>> 1: http://www.block64.net/
>>>
>>
>>
>> -------------------------------------------------------------------------
>> Check out the new SourceForge.net Marketplace.
>> It's the best place to buy or sell services for
>> just about anything Open Source.
>> http://sourceforge.net/services/buy/index.php
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>>
>>
>


