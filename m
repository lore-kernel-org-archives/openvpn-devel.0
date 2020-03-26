Date: Thu, 26 Mar 2020 15:17:56 -0400
From: Nathan Stratton Treadway <nathanst@...1517...>
Message-ID: <20200326191756.GC32337@...1518...>
References: <20200326172332.2356-1-arne@...1227...>
 <20200326172332.2356-3-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20200326172332.2356-3-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] [auth-token] Document reneweal
 mechanic of auth-token in manual
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Mar 26, 2020 at 18:23:32 +0100, Arne Schwabe wrote:
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 864f94e8..f890e7a2 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -3741,6 +3741,12 @@ argument defines how long the generated token is valid.  The
>  lifetime is defined in seconds.  If lifetime is not set
>  or it is set to 0, the token will never expire.
>  
> +The token will expire either after the lifetime of the token or after
> +not being renewed for 2 *
> +.B reneg\-sec
> +seconds. Clients are being send renewed tokens on every

s/send/sent/

(Would something like "Clients should normally be sent" or "During normal
operation, clients will be sent" be a clearer explanation of the topic?)

							Nathan

----------------------------------------------------------------------------
Nathan Stratton Treadway  -  nathanst@...1517...  -  Mid-Atlantic region
Ray Ontko & Co.  -  Software consulting services  -   http://www.ontko.com/
 GPG Key: http://www.ontko.com/~nathanst/gpg_key.txt   ID: 1023D/ECFB6239
 Key fingerprint = 6AD8 485E 20B9 5C71 231C  0C32 15F3 ADCD ECFB 6239

