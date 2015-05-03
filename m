Message-ID: <55464DBE.4010203@...1856...>
Date: Sun, 03 May 2015 18:33:02 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <CAEsd45S8+hwK9mB53mVBLO-1NSJp7YE3tx53Am83pzDL+tr8GQ@...278...>
In-Reply-To: <CAEsd45S8+hwK9mB53mVBLO-1NSJp7YE3tx53Am83pzDL+tr8GQ@...278...>
Subject: Re: [Openvpn-devel] OpenVPN argument parsing of most options
 ignores "extra" parameters
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

Hi Jonathan,

On 17-04-15 11:28, Jonathan K. Bullard wrote:
> I would like to propose a patch which complains if OpenVPN options
> include parameters that are not expected.
>
> If possible, I would like to get a "feature ACK" consensus before I
> create the patch. (If I get a "feature NAK" then I won't create the
> patch.)
>
> The patch would be to reject options that are followed by extra parameters.
>
> The error message would change from
>       Options error: Unrecognized option or missing parameter(s)
> to
>       Options error: Unrecognized option or missing or unexpected parameter(s)
>
> Perhaps the current behavior of ignoring "extra" parameters is
> purposeful, to allow options to have parameters that are ignored by
> "old" versions of OpenVPN but accepted and acted on by "new" versions
> of OpenVPN. (I think doing that is not a good idea, but maybe that's
> the way the community wants it.)
>
> The patch would break any configurations that have such "extra"
> parameters. I think that's good, because the configurations are, well,
> wrong. But there could be a lot of such configurations being used with
> current versions of OpenVPN -- who knows?
>
>
> **EXAMPLE**
>
> [...]
>
> Thoughts?

Always ;-)

I agree that silently ignoring extra parameters is not nice. However, I 
think that breaking configs after they have worked for many years might 
result in too many unpleasant surprises for our users. How would you 
feel about just issuing a warning for ignored extra parameters?

-Steffan

