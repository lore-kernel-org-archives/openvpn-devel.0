Message-ID: <5604419E.7040600@...1147...>
Date: Thu, 24 Sep 2015 20:31:58 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <55D5BB1A.5040600@...2069...><63022E09231F45E1AE0C324B02EBEADC@...1853...>	<55D5DFE8.6090602@...2069...>	<1B567537204048B6AFA217C033B94C15@...1853...>	<55D6111E.8040004@...1114...>	<55D6F599.5060407@...2069...>
	<55D71D66.4040408@...1114...> <55D74242.3070701@...2069...>
In-Reply-To: <55D74242.3070701@...2069...>
Subject: Re: [Openvpn-devel] [Openvpn-users] CRL and --CApath usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Rui Santos <rsantos@...2069...>, openvpn-users@lists.sourceforge.net
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Rui,

On 21/08/15 17:22, Rui Santos wrote:

> [...]
sorry for taking so long to get back to you on this.
I've been playing with the --capath option and revoking certificates and=20
indeed I see the behaviour that you describe:

1. the server starts, and a CRL is in the capath directory
2. client1 connects and is allowed access; later on , client1 disconnects
3. certificate client1 is revoked and a new CRL (.r0) file is copied to=20
the --capath dir. the server is NOT restarted
4. client1 can still connect to the server until the server is restarted.

this happens for OpenVPN 2.1 - 2.3 with OpenSSL 0.9.8 and 1.0.x . I've=20
always been under the impression that .r0 files were (periodically)=20
re-read by the OpenSSL routines but apparently they are not.
This can be considered a bug in OpenVPN (not OpenSSL) , as it is not=20
stated anywhere that OpenSSL should re-read the .r0 files. I've played=20
with .r1 files as well (delta CRLs) but that does not solve all issues.

I will investigate further (as this also affects my "other" job) and=20
once I have a proper solution I will post a patch.

thanks for reporting this,

JJK

> On 21-08-2015 13:45, David Sommerseth wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 21/08/15 11:55, Rui Santos wrote:
>>> On 20-08-2015 18:40, David Sommerseth wrote: On 20/08/15 19:11,
>>> debbie10t@...277... wrote:
>>>>>> ----- Original Message ----- From: "Rui Santos"
>>>>>> <rsantos@...2069...> To:
>>>>>> <openvpn-users@lists.sourceforge.net> Sent: Thursday, August
>>>>>> 20, 2015 3:10 PM Subject: Re: [Openvpn-users] CRL and
>>>>>> --CApath usage
>>>>>>
>>>>>>
>>>>>>> On 20-08-2015 15:01, debbie10t@...277... wrote:
>>>>>>>> ----- Original Message ----- From: "Rui Santos"
>>>>>>>> <rsantos@...2069...> To:
>>>>>>>> <openvpn-users@lists.sourceforge.net> Sent: Thursday,
>>>>>>>> August 20, 2015 12:33 PM Subject: [Openvpn-users] CRL and
>>>>>>>> --CApath usage
>>>>>>>>
>>>>>>>>
>>>>>>>>> I'm using --CApath option for CA and CRL
>>>>>>>>> approving/checking
>>>>>>>>>
>>>>>>>>> I just revoked a certificate, copied the new CRL to
>>>>>>>>> CApath, overwriting the old one, and the OpenVPN
>>>>>>>>> allowed > the connection with that certificate.
>>>>>>>>>
>>>>>>>>> The openssl command for this: ~# openssl verify
>>>>>>>>> -crl_check -CApath <cadir>=C3=82  cert.crt error 23 at 0
>>>>>>>>> depth lookup:certificate revoked
>>>>>>>>>
>>>>>>>>> I tried to connect several times, with success, which
>>>>>>>>> I shouldn't be able to.
>>>>>>>>>
>>>>>>>>> However, if I restart the OpenVPN service, it works as
>>>>>>>>> expected, with the error: <IP>:42410 VERIFY ERROR:
>>>>>>>>> depth=3D0, error=3Dcertificate revoked: C=3D........
>>>>>>>>> Directories leading to CApath and files are accessible
>>>>>>>>> to all user: 0755/0644
>>>>>>>>>
>>>>>>>>> I wonder if there is any kind of bug on this. Is this
>>>>>>>>> an expected behavior ? One should not need to restart
>>>>>>>>> the OpenVPN instance, just to reread the CRL.
>>>>>>>>>
>>>>>>>>> Am I missing something ?
>>>>>>>> The manual has this to say:
>>>>>>>>
>>>>>>>> Note: As the crl file (or directory) is read every time a
>>>>>>>> peer connects, if you are dropping root privileges with
>>>>>>>> --user, make sure that this user has sufficient
>>>>>>>> privileges to read the file.
>>>>>>> Hi Debbie,
>>>>>>>
>>>>>>> I'm aware of that. OpenVPN is indeed running as user
>>>>>>> nobody. But the accesses 0755/0644 for directories and
>>>>>>> files, respectively, should take care of that issue,
>>>>>>> shouldn=E2=80=99t it ?
>>>>>> Did you try *without* dropping root orivileges ?
>>> Nonsense.  If files and directories have 0655/0744, even the
>>> 'nobody' user should be able to read these files.  Also consider
>>> that *connecting* to the server DO work.
>>>> @Debbie Nonetheless, thank you for your effort. I do appreciate
>>>> you help.
>>>>>> Perhaps the crl (in PEM format) is also effected by
>>>>>> --persist-key ...
>>> This is just pure guesswork, debbie10t.  The CRL file is *NOT*
>>> affected by --persist-key.
>>>
>>>
>>> Rui:  How have you configured --crl?  Did you add the 'dir' flag
>>> when pointing to the directory?  Or did you point directly to a CRL
>>> file?
>>>> Hi David,
>>>> I assume you mean the --crl-verify option, right? If so, the
>>>> --crl-verify option is not specified at all. According to man
>>>> page, on the --crl-verify section, the you can either specify a
>>>> CRL PEM encoded file, which contains one or more CRLs
>>>> concatenated. This could be doable. With the dir flag, the
>>>> directory you specify as second parameter, must contains files
>>>> named after the serial numbers of the "revoked" certificates.
>>>> Quoting from the man page: "If  the optional dir flag is
>>>> specified, enable a different mode where crl is a directory
>>>> containing files named as revoked serial numbers (the files may
>>>> be empty, the contents are never read).  If a client requests a
>>>> connection, where the  client  certificate serial  number
>>>> (decimal string) is the name of a file present in the directory,
>>>> it will be rejected." According to my understanding, you cannot
>>>> have multiple CRLs in one dir, by using --crl-verify dir <dir>
>>>> approach. Do you agree ?
>> Yes, I meant the --crl-verify option, sorry about the misguiding here.
>>    And you're right, using the 'dir' option doesn't take CRL files but
>> empty files with the file names being certificate serial numbers of
>> revoked certificates.  The contents of these files in this 'dir' case
>> is never parsed.
>>
>>>> Nonetheless, IMHO, the use of capath is preferable, because use
>>>> just need to place both CAs and CRLs files in one directory,
>>>> c_rehash it, and that's all... all you need to do to manage it,
>>>> is to copy the CRL across, whenever a certificate is revoked. In
>>>> my case it would also be preferable, because there are multiple
>>>> CAs and CRLs, thus I would not need it to concatenate all CRLs,
>>>> every time a CRL is changed. That's why I would prefer the
>>>> capath.
>> Jan Just Keijser is truly the authority when it comes to configuring
>> OpenVPN, which also responded to you.  I double checked a few details
>> with his "OpenVPN 2 Cookbook", and I relearned some details about
>> - --capath I had forgotten.
> Hi again David,
>
> Thanks for the heads up :) I was unaware of that... I'm kind of new on
> this list.
> My first reply on this list was actually his, 9 days ago... Thanks Jan.
>> So, you can use --capath for CA certificates and their corresponding
>> CRL.  But there are a few tweaks here, so if you can double check that
>> your CRL files inside the CApath directory have the same hash as the
>> CA hash they represent, but with an .r0 extension instead of .0.  That
>> should normally be the trick.
>>
>> I hope JJK doesn't kill me for pulling out an extract of one example
>> of his book:
>>
>>     $ cd /path/to/ca/directory
>>     $ openssl x509 -hash -noout -in ca.crt
>>     bcd54da9
>>
>> This means that the CA file should be named bcd54da9.0 and the CRL
>> file should be named bcd54da9.r0
> I'm aware of that. On most Linux distributions, you may replace that
> with the following command:
> ~# c_rehash .
> It will perform all those hashes and some more. I've double checked, and
> c_rehash generates the same hashes that the standard OpenSSL command
> generates, including for the CRLs with .r0 ones.
> However it will also generate other links/hashes pointing to the same
> CAs and SubCAs. I'm unaware what those are for...
> But, since I do not use the --ca nor the --verify-crl options (only the
> --capath), OpenVPN would not even work nor read the CRLs upon restart,
> right ?
>> If this is the situation in your setup, I'd wait for JJK to test this
>> out as well.  If it turns out there's a bug or misconfiguration, he
>> will usually be able to confirm it.
> Ok. Let's let him enjoy the rest of his vacations. :)
> I'll wait.
>
> David, once again, thanks for your and time spent on this.
>>
>> - --=20
>> kind regards,
>>
>> David Sommerseth
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v2.0.22 (GNU/Linux)
>>
>> iEYEARECAAYFAlXXHWYACgkQDC186MBRfrpgwwCeOZnRngPQQupSjb4A8ZnZOyua
>> 0OQAn2fjW04b0QaB5k0SPQm16iGqbXPm
>> =3D6btd
>> -----END PGP SIGNATURE-----
>>
>>


