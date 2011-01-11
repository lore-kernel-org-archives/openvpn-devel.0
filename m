Message-ID: <4D2CC78A.1010504@...1147...>
Date: Tue, 11 Jan 2011 22:11:38 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <20110110061937.GA4712@...1446...>	<4D2C6D23.6040101@...1147...>
	<4D2C74DC.3@...453...>
In-Reply-To: <4D2C74DC.3@...453...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Using EasyRSA intermediate CA
 with OpenVPN - warning with certificate revocation list: "CRL crl.pem
 is	from a different issuer than the issuer of certificate ..."
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Erich Titl <erich.titl@...453...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Hi Erich,

(copying in the openvpn-devel list as this might be considered a minor bug)

Erich Titl wrote:
> Hi JJK
>
> at 11.01.2011 15:45, Jan Just Keijser wrote:
>   
>> Hi,
>>
>>     
> ...
>
>   
>>>   
>>>       
>> the "CRL crl.pem is from a different issuer" warning is actually an 
>> error: when OpenVPN goes through a stacked CRL list it prints out this 
>> message. This should be raised as a (minor) bug.
>> The message is harmless however, as clients with revoked certs are 
>> denied access (as I have tested myself).
>>
>> the only way to get rid of this warning is to switch to
>>   capath <directory>
>> mode, where the capath directory contains your CA certs and CRL certs as 
>> .0 and .r0 files.
>> You can generate the .0 and .r0 files using
>>   cp ca.crt    cadir/`openssl x509 -hash -noout -in ca.crt`.0
>>   cp crl.pem cadir/`openssl x509 -hash -noout -in ca.crt`.r0
>>     
>
> Now this raises a number of questions
>
> 1) is the file name suffix responsible for the warning to go away
> 2) is the hash based filename responsible ....
> 3) is the fact that both files reside in the cadir directory responsible
>
> If all 3 then what should be achieved with this condition stacking
>
>   
actually, it's all 3. OpenSSL has two ways of using certificates and 
CRLs; the first method, which is used most often, is to supply a single 
certificate file and single CRL file. The cert file and CRL file may be 
"stacked" , that is , more than one CA can be specified, related or not, 
and also more than one CRL file, related or not. The OpenVPN code 
processes the CA and CRL file and prints out the warning mentioned when 
it finds a CRL that does not belong to a particular cert. This warning 
is to prevent people from loading the wrong CRL alongside a particular 
ca.crt file. When the wrong file is loaded it is simply ignored by 
OpenSSL. It would be nicer to match each CRL against *a* certificate in 
the stacked ca.crt file, but this makes the verification algorithm a bit 
more complex.
With two certs and CRLs are stacked the warning is printed twice:
- first when CRL_1 is matched against CA_CERT_2
- second when CRL_2 is matched against CA_CERT_1

The second method for using certs and CRLs is to use a 'capath' method 
where all certs and CRLs are put in a single directory using a special 
naming scheme (the 'openssl x509 -hash' thingie). When validating a 
client certificate OpenSSL (and thus, OpenVPN) will go through each of 
the .0 files in the 'capath' directory to find a matching CA cert. It 
then looks at the corresponding .r0 file (the CRL) to check whether the 
certificate has been revoked. Due to the way OpenVPN is coded the CRL 
warning is NOT printed in this case.


cheers,

JJK


