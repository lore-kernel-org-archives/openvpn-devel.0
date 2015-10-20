From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 20 Oct 2015 17:28:17 +0300
Message-ID: <56264F81.1080603@...277...>
References: <1445347379-29943-1-git-send-email-lstipakov@...277...>
	<20151020135234.GM22054@...1296...>
Mime-Version: 1.0
In-Reply-To: <20151020135234.GM22054@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Replace variable length array with
	malloc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

> Why OPENSSL_malloc() in particular?

I looked for other malloc calls in that file and only example I've found 
was OPENSSL_malloc in show_available_curves().

On the other side Dr. Stephen Henson says (quote unedited):

http://permalink.gmane.org/gmane.comp.encryption.openssl.user/11291

> You don't have to use OPENSSL_malloc() in an application but you do
you can make use of OpenSSLs memory leak checking routines if you do.

-Lev

On 20.10.2015 16:52, Gert Doering wrote:
> Hi,
>
> On Tue, Oct 20, 2015 at 04:22:59PM +0300, Lev Stipakov wrote:
>> Commit https://github.com/OpenVPN/openvpn/commit/685e486e8b8f70c25f09590c24762ff734f94a51
>> introduced a variable length array. Although C99 supports that, MSVS 2013 still requires
>> size of array to be compiler time constant. As a fix, use OPENSSL_malloc/free.
>
> Why OPENSSL_malloc() in particular?
>
> (As I have no clue about the intricacies of openssl-interfacing code, this
> might be a stupid question, but it looks like "normal gc_malloc() should
> be perfectly fine")
>
> gert
>
>
>
> ------------------------------------------------------------------------------
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>



