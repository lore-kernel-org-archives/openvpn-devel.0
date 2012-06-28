Message-ID: <4FECCAF7.9060000@...1227...>
Date: Thu, 28 Jun 2012 23:21:59 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <4FEC9804.2070805@...1227...> <4FECB181.4070105@...1114...>
In-Reply-To: <4FECB181.4070105@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Fix --management-external-key in
	2.3alpha
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 28.06.12 21:33, schrieb David Sommerseth:
> On 28/06/12 19:44, Arne Schwabe wrote:
>>
>> Just a quick patch which fixes --management-external-key, which I need
>> for a cleaner way to access Android key store.
>>
>
> (please, don't attach the patches as attachments - rather send them as
plain text mail, easier to review and far easier for me to process these
patches afterwards when including them - git send-email is easy to set
up, which does everything correct instantly)
>
> I think I found a bug in your patch ...
>
>
> ^^^
> I believe this should the '|' should be '&' instead. At least, it
doesn't work so well when I don't change it.
> What do you think?
Yes you are right.
>
> My tests are:
>
> ./src/openvpn/openvpn --dev tun --tls-client --ca
sample/sample-keys/ca.crt --cert sample/sample-keys/client.crt
--management 127.0.0.1 1234 --remote 127.0.0.1 --key non-existing-file
> (this should fail with a "file not found" error)
>
> and
>
> ./src/openvpn/openvpn --dev tun --tls-client --ca
sample/sample-keys/ca.crt --cert sample/sample-keys/client.crt
--management 127.0.0.1 1234 --remote 127.0.0.1 --key non-existing-file
--management-external-key
>
> But ... is it expected to pass --key if you use
--management-external-key? I probably don't know enough about this
--management-external-key feature, so I might be wrong.
No. --key is not passed but --managment-external-key sets --key filename
to EXTERNAL_KEY (like inline TAG for files).

Arne


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/syvcACgkQe8+cMNS4zRcXkwCfZZg6JIM+S9pMBZzhwmHrgqZi
GFAAn3kn1uudf28fgm94+WuIQM6OlGfy
=BmbV
-----END PGP SIGNATURE-----


