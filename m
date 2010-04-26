Message-ID: <4BD5BBA3.6060707@...1114...>
Date: Mon, 26 Apr 2010 18:13:23 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1272210565-9312-1-git-send-email-dave_br@...1278...>
	<201004261608.52121.dave_br@...1278...>
	<4BD5AEF8.40603@...1114...>
	<201004261655.29152.dave_br@...1278...>
In-Reply-To: <201004261655.29152.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] Serial number export, fixed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26/04/10 17:55, Davide Brini wrote:
> On Monday 26 Apr 2010 16:19:20 David Sommerseth wrote:
> 
>>> (I still think it would be nice to have some sort of channel to send
>>> errors to OpenVPN's main log from the children scripts or programs, so
>>> users could inspect it.)
>>
>> This begins to look very good!
>>
>> Just for the errors ... they are not captured if you write to stderr or
>> stdout from the script and put into the openvpn log files?  I haven't
>> tried it, but you might know this better from experience.
> 
> They are captured (which is of course better than nothing), but they're not 
> timestamped etc.
> To give you an idea, you get something like this (lines spaced for clarity):
> 
> ---------------------------------------------------------------------
> Mon Apr 26 16:27:44 2010 TLS: Initial packet from 10.0.0.1:1194, sid=473982ac 
> 00c08d68
> 
> Error: OCSP server URL not defined!
> Did you forget to customize the variables in the script?
> 
> Mon Apr 26 16:27:44 2010 VERIFY SCRIPT ERROR: depth=0, /C=GB/O=Test client/
> 
> ...
> ---------------------------------------------------------------------
> 
> 
> Note the "bare" messages output by the script to stderr (if you output to 
> stdout, they look the same in OpenVPN's log).
> 
> One would probably expect something like this instead:
> 
> ---------------------------------------------------------------------
> Mon Apr 26 16:27:44 2010 TLS: Initial packet from 10.0.0.1:1194, sid=473982ac 
> 00c08d68
> 
> Mon Apr 26 16:27:44 2010 OCSP_check.sh: Error: OCSP server URL not defined!
> 
> Mon Apr 26 16:27:44 2010 OCSP_check.sh: Did you forget to customize the 
> variables in the script?
> 
> Mon Apr 26 16:27:44 2010 VERIFY SCRIPT ERROR: depth=0, /C=GB/O=Test client/
> 
> ...
> ---------------------------------------------------------------------
> 
> In this specific instance, it may probably be hacked somehow using logger(1) 
> with the right parameters in the script (or maybe not - I haven't tried), but 
> it would be nice if there was a general framework offered by the parent 
> OpenVPN so logs from the children would effectively be part of the parent 
> process's message flow, and treated as such (so if OpenVPN is using special or 
> customized log settings, the messages from the children would automatically be 
> processed in the same way).
> 


Thanks for the update!  Yes, I agree, this is something we should try to
improve somehow.  I'll make sure that goes into a "todo list" when the
community server is up-n-running again.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvVu6AACgkQDC186MBRfrr++QCgko0Y+sTEb+86R/nyFOpsiawu
f+MAoKQRGi7TP8p+B95cydMiO8OaZC9l
=oVom
-----END PGP SIGNATURE-----

