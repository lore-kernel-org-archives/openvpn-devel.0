Message-ID: <4E8587EC.1020201@...1114...>
Date: Fri, 30 Sep 2011 11:12:12 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <C8EBC1CC-8304-4A97-A2C6-DE114CB05EFF@...1502...>
	<B96E3F2E-F1EF-41B4-9342-16AE68F53A8D@...1502...>
	<49806E1A-9928-4272-8EF5-55943866941D@...1502...>
In-Reply-To: <49806E1A-9928-4272-8EF5-55943866941D@...1502...>
Subject: Re: [Openvpn-devel] [PATCH] Client's routes ageing timer
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
To: Davide Guerri <d.guerri@...1502...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 15/09/11 23:42, Davide Guerri wrote:
> Please find attached a patch for a new stale-routes-check (and remove)
> option.
> 
> As requested on IRC #openvpn-devel channel, I've fixed my previously
> submitted patch against version 2.1.0 (i.e. the version currently used
> by ubuntu 10.04.3 LTS) and I'm also submitting a patch against the
> latest master branch.
> 
> I've been testing both versions for a while with no issues so far.
> 

Applied to the master branch in testing and stable trees.  Next time,
could you please
commit this to your local git tree (in a separate branch, if you like)
and then use
'git format-patch' when sending patches?  That makes the inclusion
easier, as I don't
have to start writing commit messages and tweaking with git other   :)

I've added this commit message to this patch:

commit 3a957aaef3ae512b217dd475a846a0ea35aae49c
Author: Davide Guerri <d.guerri@...1502...>
Date:   Thu Sep 15 23:42:22 2011 +0200

    New feauture: Add --stale-routes-check

    This patch adds a stale-routes-check option that takes 2 parameters:
a ageing
    time (in seconds) and a check interval (in seconds). The latter
defaults to the
    former if it's not present.  Internally, a new "check" is added in
    multi_process_per_second_timers_dowork(). This check deletes stale
routes and
    it is inspired to the function multi_reap_range().

    We're running a very large connectivity infrastructure based on
openVPN (more
    than 4000 different clients connected per day per server), so we can
throughly
    check this patch (or, of course, any variant of it).

    Signed-off-by: Davide Guerri <d.guerri@...1502...>
    Reviewed-by: David Sommerseth <davids@...1347...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>


(I set myself as Reviewed-by this time, because I struggled to remember
the details - but remember having reviewed it and found it generally
useful and good.  Anyway Gert and Adriaan was clear in their ACKs.)


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6Fh+kACgkQDC186MBRfrrwdQCfXFu8hh7TdRwLcOVCUNr+PQuO
zkAAn0L58KNlcnHU9JhgT2lPLkd8P+Qp
=MtGN
-----END PGP SIGNATURE-----

