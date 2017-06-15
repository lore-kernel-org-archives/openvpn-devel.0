MIME-Version: 1.0
Date: Thu, 15 Jun 2017 12:50:40 +1000
From: Steven Haigh <netwiz@...2277...>
Message-ID: <7860b0e6a671e51e0853cf7a351d874e@...2277...>
Subject: [Openvpn-devel] Bug or Feature? Username in environment in
 auth-user-pass-verify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi all,

I'm just trying to figure out if its expected behaviour to have the 
'username' set in the environment when using the auth-user-pass-verify 
script.

My observations with 2.4.2 seems that even when auth-user-pass-verify is 
called with via-file, the username is set in the environment. The 
client-connect script does not have the username present in the 
environment.

The documentation for script-security states:
2 -- Allow calling of built-in executables and user-defined scripts.
3 -- Allow passwords to be passed to scripts via environmental variables 
(potentially unsafe).

Ok, so level 3 specifically mentions the username / password via env 
variables. No mention of level 2.

The auth-user-pass-verify documentation states:
If method is set to "via-env", OpenVPN will call script with the 
environmental variables username and password set to the 
username/password strings provided by the client. Be aware that this 
method is insecure on some platforms which make the environment of a 
process publicly visible to other unprivileged processes.

If method is set to "via-file", OpenVPN will write the username and 
password to the first two lines of a temporary file. The filename will 
be passed as an argument to script, and the file will be automatically 
deleted by OpenVPN after the script returns. The location of the 
temporary file is controlled by the --tmp-dir option, and will default 
to the current directory if unspecified. For security, consider setting 
--tmp-dir to a volatile storage medium such as /dev/shm (if available) 
to prevent the username/password file from touching the hard drive.


No mention of the username env variable when using via-file - but this 
gives me the impression that the username should *not* be set in the 
environment - but it should be in the file.

So - bug or feature?

-- 
Steven Haigh

? netwiz@...2277...     ? http://www.crc.id.au
? +61 (3) 9001 6090    ? 0412 935 897

