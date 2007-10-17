Message-ID: <9e0cf0bf0710162217k3166c507tc2536f5e545191cc@...278...>
Date: Wed, 17 Oct 2007 07:17:48 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <4073.69.149.153.97.1192576441.squirrel@...1056...>
MIME-Version: 1.0
References: <4073.69.149.153.97.1192576441.squirrel@...1056...>
Subject: Re: [Openvpn-devel] OpenVPN and OpenSSL FIPS
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
Content-Disposition: inline
To: Steve Rector <srector@...1056...>
Cc: openvpn-devel@lists.sourceforge.net

Hi!
You can post your patch here... But better rebase to BETA-2.1
Then people may help you.
Best Regards,
Alon Bar-Lev

On 10/17/07, Steve Rector <srector@...1056...> wrote:
> Hi All:
>
> I have OpenVPN-2.0.9 working with the OpenSSL FIPS module. What I've done
> is added an --enable-fips option to configure which defines a USE_FIPS
> environment variable. I also created a static variable which is set to 1
> if FIPS mode is enabled and 0 if disabled. I created a function used to
> enable fips mode, by call FIPS_mode_set that I call at the top of the main
> function in openvpn.c. I added a call to this function in each of the
> function calls in crypto.c and ssl.c that tests if fips mode is set and if
> not enables it if USE_FIPS is defined. I also changed the md5sum()
> function to a sha1sum() function since md5 is not approved in FIPS mode.
> The changes are wrapped in #ifdef USE_FIPS or #ifndef USE_FIPS as
> appropriate.
>
> I have a couple questions I hope someone can help me with, so I can get a
> patch put together for those that are interested. 1) Where is the best
> place to put the function and static variable definitions.  Should I
> create a new header and source file along the lines of fipsmode.h and
> fipsmode.c or add them to existing files?
>
> 2) On Linux there is apparently an issue with threads when running as a
> daemon and the FIPS prng. A work around found on the OpenSSL mailing list
> is to disable fips mode just prior to daemonizing and re-enable it
> afterward. Right now I am doing this in the possibly_become_daemon()
> function in init.c. Are there any crypto operations taking place at this
> point? Should this be done somewhere besides the possibly_become_daemon()
> function?
>
> I've been working my way through the code to make sure I haven't missed
> anything, but would appreciate any pointers.
>
> Thanks,
> Steve
>
>
> --
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

