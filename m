References: <20160913200458.9906-1-gert@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e5877948-6439-1c64-dfff-27f2ab85eb63@...2080...>
Date: Fri, 16 Sep 2016 16:10:54 +0200
MIME-Version: 1.0
In-Reply-To: <20160913200458.9906-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Do not abort t_client run if OpenVPN
 instance does not start.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/09/16 22:04, Gert Doering wrote:
> Basically, an oversight - if one test instance does not start at
> all (due to "tap driver not loaded") the whole script would exit,
> instead of logging the failing instance and proceeding to the next
> test run.
> 
> Signed-off-by: Gert Doering <gert@...1296...> --- 
> tests/t_client.sh.in | 10 +++++++--- 1 file changed, 7
> insertions(+), 3 deletions(-)
> 
> diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in index
> 9a0af93..62d6730 100755 --- a/tests/t_client.sh.in +++
> b/tests/t_client.sh.in @@ -279,10 +279,14 @@ do if $RUN_SUDO kill
> -0 $opid then : else -	echo -e "OpenVPN process has failed to start
> up, check log ($LOGDIR/$SUF:openvpn.log).  FAIL.\ntail of logfile
> follows:\n..." >&2 -	tail $LOGDIR/$SUF:openvpn.log >&2 +	fail
> "OpenVPN process has failed to start up, check log
> ($LOGDIR/$SUF:openvpn.log)." +	echo "tail -5 $SUF:openvpn.log" >&2 
> +	tail -5 $LOGDIR/$SUF:openvpn.log >&2 +	echo -e "\nFAIL. skip rest
> of sub-tests for test run $SUF.\n" >&2 trap - 0 1 2 3 15 -	exit 10 
> +	SUMMARY_FAIL="$SUMMARY_FAIL $SUF" +	exit_code=30 +	continue fi
> 
> # compare whether anything changed in ifconfig/route setup?
> 

ACK.  This looks reasonable and if I know Gert well enough, this is
also tested.


- -- 
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJX2/1uAAoJEIbPlEyWcf3yBigP+wRnqdDlL8TmYZlK4pJspQKk
nHfFrm1mWCJhZYlkeAlTtFrXF2K4/l/kPImdb/w5vLLdY2jT3+AxKulTcm5FVa1s
NKPhOAD/SqAzjLACWhFBK2buwFPfHzobuey821rHTNlmaNXcrMTlEntsu+hPVGyJ
jlx5Zx5Dez1JF8RbON8X1Q8bshd7cAqYMcxeUQA1xHE6EpdUDm8yLPc5tdhoMpFe
a1To6BX2X7dkZb+NE8ZhHGylOgRUBseTH+EVwKkC/AftglrmVOWKVn5hIpn5HCeS
2D/gWVeSE7F8YzOktEJEwTnE2yx3YSdoqqeFCK02HIetuBs9sH2n2lLFx0VJ9Fe9
4sLdqysJ1fZaNU6Se5/LuidUycqgDeZ8zI+GBINFPjK8VGWxZ7kSK1q9zKPneEBM
dinvB8y2etlTxsvJXiA6tH/CgfzZYwuxoWcjxcqK2LsfnKxzv8QRDQq3shALrKMe
QG7CI0ioWWONYe8j7UGQytnw5nVLH5Z2Wla+JBU1D9YN8K6HWPGw0ko6TjBwRlvJ
2eyQmO54Fq4EnwBvoDjqJYmNdeiP5/zhYalCryvp8Kdrbv6NXUzDXmVYaNcm+0+p
egJ7gh+cYvCOsbVpJ3ziZoe9aAw/+hh1BR1tGkmPPTHMFfcxTRyQhWrXodip1mK9
T7CeH9CJsFISXpjkiETU
=efGi
-----END PGP SIGNATURE-----

