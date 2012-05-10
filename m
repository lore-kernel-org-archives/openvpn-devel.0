Message-ID: <4FAB8501.2020009@...1114...>
Date: Thu, 10 May 2012 11:06:09 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4FAAE0A1.2080808@...1227...>
	<CAOazyz2wZ3n-70Pk8W_Z3OE_4_4th1PXWUOZUjOjNXetPkxc7g@...278...>
	<4FAAF152.7070508@...1227...>
In-Reply-To: <4FAAF152.7070508@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/05/12 00:36, Arne Schwabe wrote:

>> I suggest you clone the repository at github, create a branch
>> and order your changes.
> 
> 
> that would mean to revert all changes, making the changes in small
> steps and commiting each step? (I am still trying to learn how to
> work with git)

Using github is no requirement.  From what I see, all your patches was
gathered into a single file.  For this initial review, I see no issues
with that.  And the changeset isn't really that big.

Having that said, it's a good approach to have many smaller changesets
which have well defined changes which "belongs" together.  When
debugging later on, there's a neat feature in git which is called 'git
bisect', which can help you find out which commit causes the trouble.
 Smaller changes gives then a better idea how to fix it, than bigger
changes.  But of course, it makes no sense to have each line change as
a separate commit.  See the build/cleanup commits from Alon or the
PolarSSL commits (git log 0a18017..be960aa)

For the future, you may also find it easier to configure 'git
send-email' when submitting your patches, see our quick crash course
on how to do that.  Basically, if I have five commits you want to send
to the mailing list - all I do is:

    $ git send-email HEAD~5

And then patches are formatted and sent via SMTP.  If you want to have
a "cover letter", then do:

   $ git format-patch --cover HEAD~5
   (you may review 000{1..5}-*.patch)
   (edit 0000-cover-letter.patch)
   $ git send-email 0000-cover-letter.patch HEAD~5
   *or*
   $ git send-email 0000-cover-letter.patch 000[12345]-*.patch

This makes sure all your mails are nicely threaded.

git crash course:
<https://community.openvpn.net/openvpn/wiki/GitCrashCourse#Preparingforsendingpatchesviamail>

There's also other nice tweaks you can do with git there.


And that's all I want to say about git/github or anything like that in
this thread.  The rest of this thread will be about the patch contents
itself from my side.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+rhP8ACgkQDC186MBRfrrGWgCgqe1emSRs8LXAwE33SS9eUDs4
0ggAnjqUxh1gXYPLX2iqEpvfA4FIxfdX
=g4z8
-----END PGP SIGNATURE-----

