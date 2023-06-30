Date: Fri, 30 Jun 2023 13:58:26 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZJ7DYuA0ZULUWAji@...2685...>
References: <20230629215611.3292788-1-arne@...1227...>
 <20230629215611.3292788-2-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20230629215611.3292788-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] Do not blindly assume python3 is
 also the interpreter that runs rst2html
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

On Thu, Jun 29, 2023 at 11:56:07PM +0200, Arne Schwabe wrote:
> On my system python3 is the macOS system python3 while rst2html has
> 
>    #!/opt/homebrew/opt/python@...2737.../bin/python3.9
> 
> as its first line. Running that with a different python results in missing
> python modules. So directly execute the rst2html script instead.

Acked-By: Frank Lichtenheld <frank@...2641...> 

-- 
  Frank Lichtenheld

