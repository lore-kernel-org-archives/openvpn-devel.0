Message-ID: <47B9B978.20604@...1030...>
Date: Mon, 18 Feb 2008 17:59:36 +0100
From: Marcus <adesperateuser@...1030...>
MIME-Version: 1.0
References: <47B9AB97.5040407@...1030...> <47B9B157.5040505@...1012...>
In-Reply-To: <47B9B157.5040505@...1012...>
Subject: Re: [Openvpn-devel] Needing help with writing an easy-to-use
 Radius-Plugin for authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Brane F. Gračnar schrieb:
 > ... you can also check openvpn_auth:
 > http://frost.ath.cx/software/openvpn_auth/


Greetings to thee, Brane,
you are the author of that software if I am not mistaken.
I tried it already - alas with no success, although I "at least read the 
whole goddamn configuration file" to the end" ;-)

I can start the deamon successfully. (Mind that "semaphores" doesn't 
work, so I use "flock".)

I defined a "radius"-Service in the config-File:

$auth_backends = {
         radius => {
             driver => 'Radius',
             sufficient => 1,
             required => 1,
             host => '134.2.239.234',
             service => 'openvpn',
             secret => 'mysecret',
             use_nas_ipaddr => 1,
             timeout => 2
         }
};

And I installed the perl-plugins:

./bin/openvpn_authd.pl --list
Allow, AuthStruct, DBI, Deny, File, IMAP, Krb5, LDAP, PAM, POP3, Radius, 
SASL

My auth_order looks like this:
$auth_order = ["radius"];

I also did steps 8 to 10 from the Readme.

But when I try step 11, something goes wrong.

11. Check if everything works...
         export common_name="someuser.example.org"
         export untrusted_ip="1.2.3.4"
         export untrusted_port="3456"
         export script_type="auth-user-pass-verify"

Here, the documentation is not clear to me. What are the exports for? 
The client gives me an error, when i use the above values. (Maybe it's 
stupid to use the above values?)

When I run
./bin/openvpn_authc -v /tmp/sample_auth.txt I get

Feb 17 17:56:17 ovpn openvpn_authd.pl: WARN: AuthDaemon.pm, line 262, 
PRINT(): Catched output to STDOUT/STDERR: Use of uninitialized value in 
concatenation (.) or string at 
/usr/local/src/openvpn_auth-0.10/lib/Net/OpenVPN/Auth/Radius.pm line 
124, <GEN1> line 6.
Feb 17 17:56:17 ovpn openvpn_authd.pl: WARN: AuthDaemon.pm, line 263, 
PRINT(): This should not happen! Possible couses: Missing perl modules 
(running in chroot? Define $extra_modules); OR BUG in your validation 
functions, if you're using AuthStruct module; OR BUG in 
openvpn_authd.pl/it's libraries.
Feb 17 17:56:22 ovpn openvpn_authd.pl: WARN: AuthDaemon.pm, line 140, 
__ANON__(): Authentication timed out.


I probably got the settings for the radius wrong, what do you think?

Greetz, Marcus


