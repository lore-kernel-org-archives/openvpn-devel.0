References: <cover.1487368114.git.logout@...260...>
	<e5e93420586b24b7df5b2f5ac2df02ccec5ffdb1.1487368114.git.logout@...260...>
	<66d4f562-4786-f3fd-a6ae-27ebe10abf59@...1856...>
	<20170302212621.GE93896@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <735306eb-5dc4-19b0-75ad-2141fb2905b2@...1856...>
Date: Sat, 4 Mar 2017 16:13:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170302212621.GE93896@...1296...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 05/15] OpenSSL: don't use direct
 access to the internal of X509
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 02-03-17 22:26, Gert Doering wrote:
> On Thu, Mar 02, 2017 at 09:36:32PM +0100, Steffan Karger wrote:
>> So, what I propose instead is:
>>  * remove all the nsCertType code (except the option in add_option())
>>  * update the help strings and man page to indicate that --ns-cert-type
>> is no longer supported and --remote-cert-tls should be used instead
>>  * in add_option(), if the option is enabled in a config file, act as if
>> --remote-cert-tls was specified correspondingly, and print a clear
>> warning that --ns-cert-type is no longer supported and stricter checks
>> are enabled instead.
> 
> Mmmmh.  Is there a way to get the old behaviour with OpenSSL 1.1?
> 
> We decided that we do want 1.1 compatibility in release/2.4, but what
> you propose might break people's working config when upgrading from 2.4.1
> to 2.4.2 - bad enough if we make mistakes, but if there is an alternative
> to consciously changing cert validation behaviour in the middle of a
> release train, we should look again...

So I looked again, and there really seems to be no way to get the old
behaviour with OpenSSL 1.1.  However, the exact behaviour of
X509_check_purpose() is not as strict as I initially thought.  The
current patch basically adds the following checks:
 * if the cert has key usage set, it must be correct
 * if the cert has extended key usage set, it must be correct
 * if the cert has the CA flag set, it must be done correctly

These are fairly low-risk.  I'd expect quite some issues if we would
reject certs *without* (extended) key usage set, but if (e)ku is set,
this will most likely be done correctly.  Or in other words, we might
reject weird certificates, but not proper certificates.

All in all, I think the original patch (after fixing const correctness)
is fine.

As a last resort, we could consider keeping the old code inside #if
OSSL_VER < 1.1.0 in release/2.4, but that might just create more
confusion...

-Steffan

