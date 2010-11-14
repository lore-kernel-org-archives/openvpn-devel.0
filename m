Message-ID: <4CE05DD5.6040804@...1114...>
Date: Sun, 14 Nov 2010 23:08:21 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1288629206-15593-1-git-send-email-jesse.young@...277...>
	<4CDB29CF.9010206@...1114...>
	<20101111002208.GQ32214@...1430...>
In-Reply-To: <20101111002208.GQ32214@...1430...>
Subject: Re: [Openvpn-devel] [PATCH] Remove hardcoded path to resolvconf
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
To: Jesse Young <jesse.young@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/11/10 01:22, Jesse Young wrote:
> On Thu, Nov 11, 2010 at 00:25:03 +0100, David Sommerseth wrote:
> On 01/11/10 17:33, Jesse Young wrote:
>>>> Signed-off-by: Jesse Young <jesse.young@...277...>
>>>> ---
>>>>  contrib/pull-resolv-conf/client.down |    5 +++--
>>>>  contrib/pull-resolv-conf/client.up   |    5 +++--
>>>>  2 files changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/contrib/pull-resolv-conf/client.down b/contrib/pull-resolv-conf/client.down
>>>> index 38c585b..05f2d4d 100644
>>>> --- a/contrib/pull-resolv-conf/client.down
>>>> +++ b/contrib/pull-resolv-conf/client.down
>>>> @@ -34,9 +34,10 @@
>>>>  # A horrid work around, from a security perspective,
>>>>  # is to run OpenVPN as root. THIS IS NOT RECOMMENDED. You have
>>>>  # been WARNED.
>>>> +PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin
>>>>  
>>>> -if [ -x /sbin/resolvconf ] ; then
>>>> -  /sbin/resolvconf -d "${1}"
>>>> +if type resolvconf >/dev/null 2>&1; then
> 
> Hi and thank you for your patch!
> 
>> Hi David, Thanks for your comments. Hopefully, I will address them to
>> your satisfaction.
> 
> Even though I do see that this approach is much cleaner.  Hardcoded
> paths is not ideal.  But I am not sure I like this way of test.  It
> works probably fine on up-to-date systems, but will it run on all most
> bash versions?  We must consider that there are some old systems with
> older bash installations which we might break.
> 
> I'd rather see a similar patch which checks the exit code instead of
> something more undefined like this approach.  Also for clarity in the
> code of what we expect or not.
> 
>> I quickly ran this if statement in dash, bash --posix, and busybox's
>> implementation of sh, and all three worked as expected. In fact,
>> this is POSIX behavior.

Perfect!  When it's a defined standard, I'll accept it more easily :)

Applied to bugfix2.1, to be merged into allmerged and beta2.2.


commit 3adf2f558e157ef5087ca44f13e097a394ef7c78
Author: Jesse Young <jesse.young@...277...>
Date:   Mon Nov 1 11:33:26 2010 -0500

    Remove hardcoded path to resolvconf

    Signed-off-by: Jesse Young <jesse.young@...277...>
    Acked-by: David Sommerseth <dazo@...384...>
    Signed-off-by: David Sommerseth <dazo@...384...>


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkzgXdUACgkQDC186MBRfrosWgCdEqCt+ik6013KlDRN5e67WnQ+
MOsAnRvzVAlOEi7KVZbiITonVyLWGZ82
=LI99
-----END PGP SIGNATURE-----

