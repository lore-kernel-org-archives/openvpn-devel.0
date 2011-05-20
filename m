Message-ID: <4DD64230.8080605@...1114...>
Date: Fri, 20 May 2011 12:28:00 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1305544215-12654-1-git-send-email-davids@...1347...>
	<4DD6389E.2000209@...1114...> <4DD63A85.3050802@...1147...>
In-Reply-To: <4DD63A85.3050802@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Make '--comp-lzo no' the default
 behaviour if LZO is enabled
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
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 20/05/11 11:55, Jan Just Keijser wrote:
>> - From a quick brain storm, for --comp-lzo, the only compatible/valid
>> combinations are:
>>
>>    Client                      Server
>>    (no --comp-lzo)             (no --comp-lzo)
>>    --comp-lzo {,adaptive} (*)  --comp-lzo {,adaptive}
>>    --comp-lzo yes         (*)  --comp-lzo yes
>>    --comp-lzo no          (*)  --comp-lzo no
>>
>> (*) In these combinations, comp-lzo should be pushable which can change the
>> client setting.  If client does not have comp-lzo in its config, it should
>> disconnect from the server if the server pushes --comp-lzo settings, as the
>> wire protocol from the server will be different from what the client
>> expects.
>>
>>   
> please remember the reason for this patch: bug
>  https://community.openvpn.net/openvpn/ticket/128
> 
> if there is a 'comp-lzo' mismatch and the server pushes out 'push "comp-lzo
> yes"' then upon reconnecting it works all of a sudden - this inconsistency
> needs to be addressed one way or the other.
> If we don't want to change the 'comp-lzo' behaviour then at the very least
> this "reconnect-makes-it-work" feature/bug should be fixed in a different
> manner.

Hi Jan,

Yeah, that is the reason why I think a disconnect should happen when the
client is not using comp-lzo (no --comp-lzo defined), while the server
pushes it.  This is a misconfiguration to start with.  However, when the
client disconnects and stops running, it should give a sensible error
message - to help solve this issue.

Why it "works" with a reconnect, is that the first connect fails because
client config is not using --comp-lzo.  But the server managed to get a
- --comp-lzo push through, which then enables it on the client on the next
reconnect.  This is actually a the real misbehaviour, and is a bug.

When this bug is fixed, we can consider an "auto-fix feature", where it
will reconnect with '--comp-lzo no' in this kind of situation, without
giving odd errors in the log files.  This auto-fix feature should probably
be possible to disable, for those wanting more control over what's happening.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3WQjAACgkQDC186MBRfroqZQCeOMiuIGsYgze9omfQpjiL9Zfg
6IQAn1ffLU1b1LV9a5nhmuWCWm4XCoKH
=dILR
-----END PGP SIGNATURE-----

