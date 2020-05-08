References: <20200508114243.15532-1-davids@...515...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <784cbc0e-b1f9-eb91-1a2b-3c3f95758a97@...2181...>
Date: Fri, 8 May 2020 22:56:09 +0200
MIME-Version: 1.0
In-Reply-To: <20200508114243.15532-1-davids@...515...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] options: Fix failing inline
 tls-auth/crypt with persist-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

Hi,

On 08/05/2020 13:42, David Sommerseth wrote:
> A configuration file using --persist-key and with inlined --tls-auth or
> --tls-crypt files was failing in check_file_access().  The file argument
> to check_file_access() contained the key file and not the file name.
> 
> This was because check_file_access_inline() which calls
> check_file_access() if the file is not inlined was told the file was not
> an inline file.
> 
> The reason the check_file_access_inline() was misled was due to a prior
> option_postprocess_mutate() call puts these key files into a connection
> block entry in option_postprocess_mutate_ce().  OpenVPN was modified a
> long while ago to always use connection blocks in the option structure
> for simplicity.  So the "root" key files would be transferred into a
> connection entry in this method.
> 
> When --persist-key is used, option_postprocess_mutate_ce() will load the
> key file and "convert" the option into an inline option.  But in
> commit cb2e9218f2bc73fa2 this logic had lost the "inline indicator".  The
> result was that the connection entry had the key file content stored in
> the object but was "tagged" as a normal file (name) not an inline file.
> 
> Signed-off-by: David Sommerseth <davids@...515...>

Thanks for fixing my bugs :-)
Unfortunately the code has changed a bit since the issue of v1 until
v11...so these nasty errors sneaked in.


Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

