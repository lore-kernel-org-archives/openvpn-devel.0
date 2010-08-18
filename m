Message-ID: <4C6BDE6C.6020906@...68...>
Date: Wed, 18 Aug 2010 15:21:48 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1282134451-21285-1-git-send-email-dazo@...384...>
	<4C6BD3CB.5050009@...68...> <4C6BD90E.2050707@...1114...>
In-Reply-To: <4C6BD90E.2050707@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Test framework improvment - Do not FAIL
 if	t_client.rc is missing
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

Am 18.08.2010 14:58, schrieb David Sommerseth:
> On 18/08/10 14:36, Matthias Andree wrote:
>> Am 18.08.2010 14:27, schrieb David Sommerseth:
>>> This is to avoid 'make check' fail if this extra test case is not
>>> configured.  The patch gives a PASS, but will notify the user that
>>> this test was skipped.
> 
>> The right approach would be to "exit 77" instead of 0,
>> so that "make check" can report the SKIP properly.  Assuming that t_client.sh is
>> listed in TESTS in some Makefile.am, which I didn't check.
> 
> 
> Ahh!  There it was!  I thought I had seen this before, but I couldn't
> find any good references in the automake manual so far.  I'll fix this
> and send a new patch.

In automake 1.10, it's in chapter 15.1 "Simple Tests" in the second paragraph:

|    The number of failures will be printed at the end of the run.  If a
| given test program exits with a status of 77, then its result is ignored
| in the final count.  This feature allows non-portable tests to be
| ignored in environments where they don't make sense.

Which is not exactly stating the more common use case, as the whole chapter is
rather compact... The feature is still suitable.

On a related node, I personally prefer printing a message how a test could be
enabled, followed by exit 77, over removing unrunnable tests from the TESTS
variable.  See bogofilter.sourceforge.net (either use SVN, or a recent tarball),
particularly src/tests{/Makefile.am|/*} and doc/Makefile.am for an example of a
more elaborate test suite.

Not necessarily the best, and there are more powerful frameworks than what we
use, but it also shows how far the simple automake tests can be taken already,
and perhaps some ideas can be useful.

-- 
Matthias Andree

