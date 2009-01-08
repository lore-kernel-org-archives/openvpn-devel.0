Message-ID: <4965B51E.5080409@...1114...>
Date: Thu, 08 Jan 2009 09:11:10 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <0EA36262921E4274824D60F7BA592C13@...1094...>
In-Reply-To: <0EA36262921E4274824D60F7BA592C13@...1094...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Fw: [oCERT-2008-016] Multiple
 OpenSSL signature verification API misuses
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
To: Bonno Bloksma <b.bloksma@...1093...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Bonno Bloksma wrote:
> Hi,
>  
> Does this affect OpenVPN as well? I think so?
>  
> If I'm right this wil be fied automatically as soon as my Linux server
> get's the updated OpenSSL package, right?
>  
> How about Windows users? Isn't the OpenSSL in that version static linked?

I had a quick look into this yesterday.  I did not find anything that
OpenVPN itself should not be vulnerable to this issue at all.

That being said, OpenVPN do use some callback functionality where the
OpenSSL library does some of the validation of the certificates and
provides a result back to a function in OpenVPN.

I also had a quick look into the OpenSSL source code, but could not find
anything particular here.  But following the way OpenSSL works is not too
easy, is it was not clear to me when the callback function into OpenVPN
would be called.  I found some points, but it did not make too much sense
for me.

So the conclusion for me is that, OpenVPN is not vulnerable as a separate
package, as it do not make use of the EVP_VerifyFinal() function.  One
line in the OpenVPN code can be made even stricter regarding certificate
validation, where there is a check like (ssl.c:654, IIRC):

	if (!preverified_ok)

This could be changed to:

	if (preverified_ok != 1)

But, this is probably not needed as the documentation for the
SSL_CTX_set_verify() function which sets the callback function for
OpenSSL, states clearly that this value will be set to 1 or 0, and nothing
else.  But of course, OpenSSL can in theory send even another value here.
 And I do see that changes like in my suggestion here is also found in the
patch for OpenSSL.

So what to do?  I suggest upgrading the OpenSSL library.  OpenVPN most
probably will not need any fixes, unless somebody really insists on the
change I've suggested here.  For the Windows build, I do not know how the
linking is done.  If it is static as you fear, OpenVPN will need to be
rebuilt against a new OpenSSL library.


kind regards,

David Sommerseth


> ----- Original Message -----
> *From:* Will Drewry <mailto:redpig@...1179...>
> *To:* ocert-announce@...1180...
> <mailto:ocert-announce@...1180...> ;
> oss-security@...1181... <mailto:oss-security@...1181...>
> ; bugtraq@...1182... <mailto:bugtraq@...1182...>
> *Sent:* Wednesday, January 07, 2009 3:56 PM
> *Subject:* [oCERT-2008-016] Multiple OpenSSL signature verification API
> misuses
> 
> #2008-016 multiple OpenSSL signature verification API misuse
> 
> Description:
> 
> Several functions inside the OpenSSL library incorrectly check the result
> after calling the EVP_VerifyFinal function.
> 
> This bug allows a malformed signature to be treated as a good signature
> rather than as an error. This issue affects the signature checks on DSA
> and ECDSA keys used with SSL/TLS.
> 
> The flaw may be exploited by a malicious server or a man-in-the-middle
> attack that presents a malformed SSL/TLS signature from a certificate
> chain to a vulnerable client, bypassing validation.
> 
> A patch fixing the issue with proper return code checking and further
> important recommendations are described in the original OpenSSL Team
> advisory.
> 
> At the request of the OpenSSL team, oCERT has aided in the remediation
> coordination for other projects with similar API misuse vulnerabilities.
> In addition to EVP_VerifyFinal, the return codes from DSA_verify and
> DSA_do_verify functions were being incorrectly validated, and packages
> doing so are affected in a similar fashion as OpenSSL.
> 
> 
> Affected version:
> 
> OpenSSL <= 0.9.8i [1]
> 
> The following packages were identified as affected by the same OpenSSL
> vulnerability, as they use OpenSSL EVP_VerifyFinal function and
> incorrectly check the return code.
> 
> NTP <= 4.2.4p5 (production), <= 4.2.5p150 (development)
> 
> Sun GridEngine <= 5.3
> 
> Gale <= 0.99
> 
> OpenEvidence <= 1.0.6
> 
> Belgian eID middleware - eidlib <= 2.6.0 [2]
> 
> Freedom Network Server <= 2.x
> 
> The following packages were identified as affected by a vulnerability
> similar to the OpenSSL one, as they use OpenSSL DSA_verify function and
> incorrectly check the return code.
> 
> BIND <= 9.4.3
> 
> Lasso <= 2.2.1
> 
> ZXID <= 0.29
> 
> 1 - use of OpenSSL as an SSL/TLS client when connecting to a server whose
> certificate uses an RSA key is NOT affected. Verification of client
> certificates by OpenSSL servers for any key type is NOT affected.
> 
> 2 - Belgian eID middleware latest versions are not available in source
> form, therefore we cannot confirm if they are affected
> 
> 
> Fixed version:
> 
> OpenSSL >= 0.9.8j
> 
> NTP >= 4.2.4p6 (production), >= 4.2.5p153 (development)
> 
> Sun GridEngine >= 6.0
> 
> Gale N/A
> 
> OpenEvidence N/A
> 
> Belgian eID middleware - eidlib N/A
> 
> Freedom Network Server N/A
> 
> BIND >= 9.3.6-P1, 9.4.3-P1, 9.5.1-P1, 9.6.0-P1
> 
> Lasso >= 2.2.2
> 
> ZXID N/A
> 
> 
> Credit: Google Security Team (for the original OpenSSL issue).
> 
> 
> CVE: CVE-2008-5077 (OpenSSL),
>         CVE-2009-0021 (NTP),
>         CVE-2009-0025 (BIND)
> 
> 
> Timeline:
> 2008-12-16: OpenSSL Security Team requests coordination aid from oCERT
> 2008-12-16: oCERT investigates packages affected by similar issues
> 2008-12-16: contacted affected vendors
> 2008-12-17: investigation expanded to DSA verification
> 2008-12-17: BIND, Lasso and ZXID added to affected packages
> 2008-12-18: contacted additional affected vendors
> 2009-01-05: status updates and patch dissemination to affected vendors
> 2009-01-05: confirmation from BIND of issue and fix
> 2009-01-06: requested CVE assignment for BIND
> 2009-01-07: advisory published
> 
> 
> References:
> http://openssl.org/news/secadv_20090107.txt
> 
> 
> Links:
> http://openssl.org/
> http://www.ntp.org/
> http://gridengine.sunsource.net/
> http://gale.org/
> http://www.openevidence.org/
> http://eid.belgium.be/
> http://www.google.com/codesearch/p?#1vGzyQX--LU/achilles/remailer/zero-knowledge/freedomserver-2.x.tgz/
> https://www.isc.org/products/BIND
> http://lasso.entrouvert.org/
> http://www.zxid.org/
> 
> 
> Permalink:
> http://www.ocert.org/advisories/ocert-2008-016.html
> 
> 
> --
> Will Drewry <redpig@...1179... <mailto:redpig@...1179...>>
> oCERT Team :: http://ocert.org
> 
> 
> ------------------------------------------------------------------------
> 
> ------------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It is the best place to buy or sell services for
> just about anything Open Source.
> http://p.sf.net/sfu/Xq1LFB
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Openvpn-users mailing list
> Openvpn-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-users

