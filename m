Message-ID: <4ECA41BB.2030908@...1114...>
Date: Mon, 21 Nov 2011 13:19:07 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1321876765-16500-1-git-send-email-davids@...1347...>
	<1321876765-16500-2-git-send-email-davids@...1347...>
	<20111121120722.GO8496@...1296...>
In-Reply-To: <20111121120722.GO8496@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Clean-up: check_subnet_conflict()
 function was #if 0 -> remove it
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
To: Gert Doering <gert@...1296...>
Cc: James Yonan <james@...515...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 21/11/11 13:07, Gert Doering wrote:
> hi,
> 
> On Mon, Nov 21, 2011 at 12:59:25PM +0100, David Sommerseth wrote:
>> As the body of the check_subnet_conflict() function was disabled
>> with an #if 0 clause, remove this function and clean up all places
>> this function was called.
>> 
>> This function also expected get_default_gateway() to return data, 
>> which it does not do any more.  Hence this function is "out-of-date"
>> and no longer usefull.
> 
> I agree with the assessment, but come to a different conclusion - I
> think the functionality is worthwile to have, so maybe we should try
> to repair it, instead of throwing it out completely.
> 
> Meeting topic?

Agreed, lets put this on the agenda.  I've Cc'ed James, so that he can
have a look at it too.

This warning feature got disabled in
commit 7fb0e07ec3f7c5f6514523085dbe02ea6b8933e2 [1], which refactored a
lot of the depending code of check_subnet_conflict().  We would need to
fix get_default_gateway() again.  And further figure out what the reason
for all those false positives.

This commit doesn't change any behaviour, as this code is already removed
via the #if 0.  Hopefully most compilers won't bring in calls to an empty
function (which is the current state of check_subnet_conflict() now)



kind regards,

David Sommerseth


[1]
<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=commitdiff;h=7fb0e07ec3f7c5f6514523085dbe02ea6b8933e2>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7KQbkACgkQDC186MBRfrotHQCfWSA/TXLueXP5+fp3pjlDXBcp
f2YAnjRuuc7WbPtT1Mgn+GtZbUC+Ewwp
=k46c
-----END PGP SIGNATURE-----

