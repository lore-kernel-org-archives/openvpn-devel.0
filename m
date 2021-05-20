References: <20210520150932.2565217-1-arne@...1227...>
 <20210520150932.2565217-2-arne@...1227...>
 <CNUI9sxE2HOdFvol4LftF6DPWGfmpSUabfpLXMOJQXcFcL_bM-zvF9u3oX68guJWALVYyC13DWKt4-9cVq3c8KjneyoFY32pgNpNYCQmTIM=@protonmail.com>
 <46a3a2a9-83a4-2fbe-2fd4-684a51c001f9@...1227...>
 <nehG6AKTksx4AeryA432f6vVe5OGFQSmkbS2TYGGS6MumnC0d8xRfGsZxR_uXmDN2b8Yfvt6zQX0fwG83sqvWlyuLsdneHWr-3Wz8vDc9Qw=@protonmail.com>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <624a3ba5-aa78-144b-ff48-17ccd522588c@...1147...>
Date: Thu, 20 May 2021 23:05:32 +0200
MIME-Version: 1.0
In-Reply-To: <nehG6AKTksx4AeryA432f6vVe5OGFQSmkbS2TYGGS6MumnC0d8xRfGsZxR_uXmDN2b8Yfvt6zQX0fwG83sqvWlyuLsdneHWr-3Wz8vDc9Qw=@protonmail.com>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Add detailed man page section to
 setup a OpenVPN setup with peer-fingerprint
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: tincantech <tincantech@...2282...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 20/05/21 21:49, tincantech via Openvpn-devel wrote:
>
>>> Hi,
>>> again, I do not understand why openvpn choose to switch to .pem
>>> for this tutorial.  PEM -> Private Email, which this is not.
>>> You have a certificate and a key and every other openvpn tutorial
>>> on openvpn and probably the entire planet uses .crt and .key.
>>> This seems to be a poor decision in my opinion.
>> pem as extension for keys is pretty common and specifies more the
>> encoding than the type. E.g. there is also the der encoding.
>>
>> Arne
> I accept the principle but openvpn *only* uses PEM-enc, that I know of.
>
> So, why switch to .pem when it has never been used before by openvpn?
>
> If you are all happy to let it go that way then so-be-it,
>

Hopefully this clarifies things:
- the default output format of OpenSSL is PEM-encoded ; openssl uses the 
default extension .pem
- the OpenVPN .crt and .key files are ALSO PEM-encoded by default, but 
they've just been named differently by the easy-rsa tools to ensure that 
the files can be easily loaded on Windows

- FTR: nearly all webservers I have ever seen are configured to use a 
hostcert.pem and hostkey.pem and my guess is that there are (still) 
more  Linux-based webservers out there than OpenVPN clients and servers.

Having said that, I do agree that after using .crt/.key files left and 
right (to accomodate Windows users) for over 15 years, it does seem 
confusing to start using files named .pem for peer-fingerprinting all 
of  sudden. On the other hand, with peer-fingerprinting you don't  
*HAVE* a .crt file (at least, you don't need one, technically) but only 
a .key file. So choosing a different extension for peer-fingerprinting 
does have its merits.

HTH,

JJK


