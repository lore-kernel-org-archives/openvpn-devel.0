References: <20210520150932.2565217-1-arne@...1227...>
 <20210520150932.2565217-2-arne@...1227...>
 <CNUI9sxE2HOdFvol4LftF6DPWGfmpSUabfpLXMOJQXcFcL_bM-zvF9u3oX68guJWALVYyC13DWKt4-9cVq3c8KjneyoFY32pgNpNYCQmTIM=@protonmail.com>
 <46a3a2a9-83a4-2fbe-2fd4-684a51c001f9@...1227...>
 <nehG6AKTksx4AeryA432f6vVe5OGFQSmkbS2TYGGS6MumnC0d8xRfGsZxR_uXmDN2b8Yfvt6zQX0fwG83sqvWlyuLsdneHWr-3Wz8vDc9Qw=@protonmail.com>
 <624a3ba5-aa78-144b-ff48-17ccd522588c@...1147...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c4a25e0f-6946-924a-20e4-c0403c47965a@...1227...>
Date: Thu, 20 May 2021 23:24:55 +0200
MIME-Version: 1.0
In-Reply-To: <624a3ba5-aa78-144b-ff48-17ccd522588c@...1147...>
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
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>


> Hopefully this clarifies things:
> - the default output format of OpenSSL is PEM-encoded ; openssl uses 
> the default extension .pem
> - the OpenVPN .crt and .key files are ALSO PEM-encoded by default, but 
> they've just been named differently by the easy-rsa tools to ensure 
> that the files can be easily loaded on Windows
>
> - FTR: nearly all webservers I have ever seen are configured to use a 
> hostcert.pem and hostkey.pem and my guess is that there are (still) 
> more  Linux-based webservers out there than OpenVPN clients and servers.
>
> Having said that, I do agree that after using .crt/.key files left and 
> right (to accomodate Windows users) for over 15 years, it does seem 
> confusing to start using files named .pem for peer-fingerprinting all 
> of  sudden. On the other hand, with peer-fingerprinting you don't  
> *HAVE* a .crt file (at least, you don't need one, technically) but 
> only a .key file. So choosing a different extension for 
> peer-fingerprinting does have its merits.

I am used a lot more used to calling these files pem files. I suggest we 
put that just on the agenda for the next openvpn-meeting, if people have 
strong preferences there.

And no, you still need cert and key like for a normal TLS connection 
with peer-fingerprint. It *only* replacing the normal check of the 
certificate with a fingerprint. Basically the same principle that 
browsers do when you do cert-pinning.

Arne


