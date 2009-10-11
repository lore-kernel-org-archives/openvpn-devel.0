Message-ID: <BLU0-SMTP4766D046DAC27387E8F14BBC90@...512...>
Date: Sun, 11 Oct 2009 14:45:33 +0200
From: The Zep Man <the_zep_man@...160...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Feature request: Client-side username/password
 retrieval using environment variables
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
To: openvpn-devel@lists.sourceforge.net

Dear openvpn-devel list,

OpenVPN supports verification of a username/password combination on the 
server-side by parsing these to a 'script' using auth-user-pass-verify'. 
With this, it is possible to use a file ('via-file') or environment 
variables ('via-env') to parse the given username and password for 
verification. The 'script' returns exit code 0 if the username and 
password are correct or non-0 if they are incorrect.

On the client-side, the only way to specify a username and a password 
(using the option 'auth-user-pass') is by directly using the OpenVPN 
prompt or (by default not possible because it isn't copmiled in) by 
using a file with on the first line the username and on the second line 
the password.

While it is easy to extend the username/password verification on the 
server, it isn't easy to extend the username/password input on the 
client. Even if OpenVPN is recompiled with the required option enabled 
for the client to accept a username/password from an earlier process, it 
is far from secure (because under some OS, like Windows, the 
username/password combination must be written plain-text to the disk for 
this to work).

Would it be a good idea to let OpenVPN on the client-side accept a 
username and a password as input from two separate environment variables 
using an extra option in the configuration file (when 'auth-user-pass' 
is also used)? This would make it easier to write an enduser-friendly 
front-end for OpenVPN which asks for an username and password.

My suggestion is to extend 'auth-user-pass [up]' to 'auth-user-pass 
via-file [up]' and 'auth-user-pass via-env'. By using 'via-env', the 
username and password should be taken from pre-specified environment 
variables. Perhaps the environment variables should be 'username' and 
'password', the same names 'auth-user-pass-verify' on the server uses.

Because this option would be more secure for Windows, would it also be 
possible to enable 'auth-user-pass via-env' by default during compilation?

Best regards,

Zep

