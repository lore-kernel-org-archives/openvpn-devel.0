Message-ID: <45661CFE.3030706@...41...>
Date: Thu, 23 Nov 2006 16:13:18 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <C0170D0AF1277849A4B4518034F855DD01691E82@...916...>
In-Reply-To: <C0170D0AF1277849A4B4518034F855DD01691E82@...916...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Fix for verify_callback memory
	leak
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Harris, Jeff" <JeffH@...925...>
Cc: openvpn-devel@lists.sourceforge.net

Harris, Jeff wrote:
> I have attached a patch which corrects the memory leak associated with
> long-running client connections.  The fix creates a local set of
> environment variables each time the verification occurs.  The set is
> initialized with the session's variables before adding the ones created
> during the verification.  The local set is then freed at the end.  The
> patch also applies the same approach to the password verification
> functions.
>
> Please have a look at the patch and reply if there are errors with my
> approach. 
>   

Right -- I understand the problem, however I would fix it differently.

We don't want to use a local name=value pair store because these 
name=value pairs are supposed to be persistent over the life of the 
client connection, so that other callback scripts or plugins which 
execute later can have access to them.

This is my solution:

svn diff -r1461:1493 
http://svn.openvpn.net/projects/openvpn/branches/BETA21/openvpn

------------------------------------------------------------------------
r1493 | james | 2006-11-23 15:05:14 -0700 (Thu, 23 Nov 2006) | 12 lines
Changed paths:
   M /branches/BETA21/openvpn/init.c
   M /branches/BETA21/openvpn/misc.c
   M /branches/BETA21/openvpn/misc.h
   M /branches/BETA21/openvpn/openvpn.h

Fixed issue where struct env_set methods that
change the value of an existing name=value pair
would delay the freeing of the memory held by
the previous name=value pair until the underlying
client instance object is closed.

This could cause a server that handles long-term
client connections, resulting in many periodic calls
to verify_callback, to needlessly grow the env_set
memory allocation until the underlying client instance
object is closed.

James


