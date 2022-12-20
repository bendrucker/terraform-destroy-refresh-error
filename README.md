# terraform-destroy-refresh-error

> Reproducing "Invalid index" returned by Terraform for destroyed resource instances

## Reported

`terraform destroy` is failing with a variety of `Invalid index` errors. These errors are reported for the `value` expression of outputs that reference resources with `count`, e.g., `my_resource.foo[0].my_attribute`. The user's Terraform version is 1.3.4.

## Notes

In the past, heavily-used modules such as [`terraform-aws-modules/eks/aws`](https://github.com/terraform-aws-modules/terraform-aws-eks/pull/1041) have commonly worked around similar destroy-time errors using `join` and the splat operator:

```tf
join("", my_resource.foo[*].my_attribute)
```

## Results

The [test results](https://github.com/bendrucker/terraform-destroy-refresh-error/actions/runs/3744661914) indicate that this was a regression in 1.3.4, fixed in 1.3.5 by https://github.com/hashicorp/terraform/pull/32208. They were unable to reproduce the similar error encountered in the wild in older versions of Terraform, which is unexpected. However, given that the splat operator workaround is no longer popular and has been removed from `terraform-aws-modules/eks/aws`, it's safe to conclude that the error was caused by a patched regression and that modules do not need to employ workarounds for modern Terraform versions. 
