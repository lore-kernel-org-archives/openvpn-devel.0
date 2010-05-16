Message-ID: <4BF0306E.8090401@...1114...>
Date: Sun, 16 May 2010 19:50:38 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1272484431-14512-1-git-send-email-dave_br@...1278...>
	<4BD89863.1070309@...1114...>
	<201004282135.10485.dave_br@...1278...>
In-Reply-To: <201004282135.10485.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] OCSP_check.sh: new check logic
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
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/04/10 22:35, Davide Brini wrote:
> On Wednesday 28 April 2010, David Sommerseth wrote:
> 
>>> +    status=$(openssl ocsp -issuer "$issuer" \
>>> +                    "$nonce" \
>>> +                    -CAfile "$verify" \
>>> +                    -url "$ocsp_url" \
>>> +                    -serial "0x${serial}" 2>/dev/null)
>>> +
>>> +    if [ $? -eq 0 ]; then
>>> +      # check that it's good
>>> +      if echo "$status" | grep -Fq "0x${serial}: good"; then
>>> +        exit 0
>>> +      fi
>>> +    fi
>>>    fi
>>
>> What if you just send the result from openssl to awk via a pipe, and
>> call 'exit {0,1}' from awk depending on if it's good or not ... that
>> way, you' don't have to do this grep trickery.
>>
>> Something like this:
>> <untested>
>>    openssl ... | awk 'BEGIN{ret=1} /0x(.*): good/{ ret=0; exit } END{
>> exit ret}'
>>    exit $?
>> </untested>
> 
> Yes, the problem with this is that the pipeline's exit status is that of the 
> last command in the pipeline, and there's no standard way to know the exit 
> status of previous commands in the pipeline. 
> So in your example, if openssl failed for some reason but awk didn't, $? would 
> be 0, whereas we want the whole thing to fail in that case.
> 
> Bash (and some other shell probably) has some special variables to handle 
> these situations, which however are extensions and thus not standard.
> 
> Now, one could argue that if openssl fails, surely the output will not contain 
> the magic line we're looking for, and thus awk/grep will fail too. While this 
> is probably true in this specific instance, I feel that testing the exit 
> status of openssl separately is safer and cleaner.
> 
> This also makes it possible (although I didn't implement it) to provide more 
> detailed error messages, so one could exit with "openssl failed" (and, 
> depending on the actual exit status, even provide the exact error explanation) 
> or "openssl ran successfully, but the certificate status is not good".
> Instead, if one does just
> 
> if openssl ocsp .... | grep; then
>   # good
> else
>   # error
> fi 
> 
> all one can say in the "error" branch is the fairly generic "either openssl OR 
> grep failed", and the actual exit status of openssl would be inaccessible.
> 

With this in mind, that OpenSSL can in some circumstances return "good"
while the exit code is != 0 indicating that OpenSSL did have troubles
verifying the certificate - this is the sensible approach ... so ACK!

Patch applied to bugfix2.1 and merged into allmerged
commit 9ca155403ec72c7152bcb05c4bf8588c7cf2617b


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvwMG4ACgkQDC186MBRfrqyQgCfRoRTzxDHNFp5ROGCSFgq1+lG
oP0An0YXmczAz/QZ60zoyUNcpA4bp74S
=m605
-----END PGP SIGNATURE-----

